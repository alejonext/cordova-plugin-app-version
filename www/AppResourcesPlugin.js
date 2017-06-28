// Returns a jQuery or AngularJS deferred object, or pass a success and fail callbacks if you don't want to use jQuery or AngularJS
var getPromisedCordovaExec = function (command, success, fail, args) {
  var toReturn, deferred, injector, $q;
  if (success === undefined) {
    if (window.jQuery) {
      deferred = jQuery.Deferred();
      success = deferred.resolve;
      fail = deferred.reject;
      toReturn = deferred;
    } else if (window.angular) {
      injector = angular.injector(["ng"]);
      $q = injector.get("$q");
      deferred = $q.defer();
      success = deferred.resolve;
      fail = deferred.reject;
      toReturn = deferred.promise;
    } else if (window.when && window.when.promise) {
      deferred = when.defer();
      success = deferred.resolve;
      fail = deferred.reject;
      toReturn = deferred.promise;
    } else if (window.Promise) {
      toReturn = new Promise(function(c, e) {
        success = c;
        fail = e;
      });
    } else if (window.WinJS && window.WinJS.Promise) {
      toReturn = new WinJS.Promise(function(c, e) {
        success = c;
        fail = e;
      });
    } else {
      return console.error('AppResources either needs a success callback, or jQuery/AngularJS/Promise/WinJS.Promise defined for using promises');
    }
  }
  // 5th param is NOT optional. must be at least empty array
  cordova.exec(success, fail, "AppResources", command, args || []);
  return toReturn;
};

var getAppResources = function (success, fail) {
  return getPromisedCordovaExec('getVersionNumber', success, fail);
};

getAppResources.getAppName = function (success, fail) {
  return getPromisedCordovaExec('getAppName', success, fail);
};

getAppResources.getPackageName = function (success, fail) {
  return getPromisedCordovaExec('getPackageName', success, fail);
};

getAppResources.getVersionNumber = function (success, fail) {
  return getPromisedCordovaExec('getVersionNumber', success, fail);
};

getAppResources.getVersionCode = function (success, fail) {
  return getPromisedCordovaExec('getVersionCode', success, fail);
};

getAppResources.getResources = function (name, success, fail) {
  return getPromisedCordovaExec('getResources', success, fail, [ name ]);
};

module.exports = getAppResources;