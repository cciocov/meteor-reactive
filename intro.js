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
  return (function() {
    var _, Base64, EJSON, EJSONTest, Meteor, Package, Tracker, ReactiveDict,
        ReactiveVar;
