/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'clitest',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    contentSecurityPolicy: {
      "style-src": "'self' 'unsafe-inline' apis.google.com fonts.googleapis.com",
      "img-src": "'self' data: ssl.gstatic.com",
      "script-src": "'self' 'unsafe-inline' 'unsafe-eval' www.google.com www.gstatic.com apis.google.com shield.com:35729 192.168.1.48:35729",
      "frame-src": "www.google.com",
      "report-uri": "'self'",
      "connect-src": "'self' ws://shield.com:35729 ws://192.168.1.48:35729",
      "font-src" : "'self' fonts.googleapis.com fonts.gstatic.com"
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'auto';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
