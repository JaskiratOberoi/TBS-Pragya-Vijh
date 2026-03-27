"use strict";

module.exports = () => ({
  upload: {
    config: {
      sizeLimit: 10 * 1024 * 1024,
    },
  },
  "users-permissions": {
    config: {
      jwt: {
        expiresIn: "30d",
      },
    },
  },
});
