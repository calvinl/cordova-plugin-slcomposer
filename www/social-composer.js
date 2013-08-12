//
// SocialComposer.js
//
// Created by Calvin Lai on  2013-08-11.
// Copyright 2013 Calvin Lai. All rights reserved.

var cordova = require('cordova'),
    exec = require('cordova/exec');

var SocialComposer = function() {
  // constructor
};

// Call this to register for push notifications and retreive a deviceToken
SocialComposer.prototype.compose = function(options, success, error) {
  if (arguments.length == 2) {
    error = function(err) { console.log(err); };
  }
  cordova.exec(success, error, "SocialComposer", "compose", options ? [options] : []);
};

var socialComposer = new SocialComposer();

module.exports = socialComposer;
