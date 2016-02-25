// if the module has no dependencies, the above pattern can be simplified to
(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define([], factory);
  }
  else if (typeof module === 'object' && module.exports) {
    module.exports = factory();
  }
  else {
    root.MeteorReactive = factory();
  }
}(this, function () {
  var _, Base64, EJSON, EJSONTest, Meteor, Package, Tracker, ReactiveDict, ReactiveVar;

