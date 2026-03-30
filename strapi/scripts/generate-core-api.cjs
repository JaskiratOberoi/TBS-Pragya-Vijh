/**
 * Strapi 5: schema-only APIs need core routes, controllers, and services.
 * createCoreRouter wires to controller actions (e.g. find); without createCoreController those are missing.
 */
"use strict";

const fs = require("fs");
const path = require("path");

const apiRoot = path.join(__dirname, "../src/api");

function writeIfChanged(filePath, body) {
  const prev = fs.existsSync(filePath) ? fs.readFileSync(filePath, "utf8") : "";
  if (prev === body) return false;
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, body, "utf8");
  return true;
}

for (const apiName of fs.readdirSync(apiRoot)) {
  const apiPath = path.join(apiRoot, apiName);
  if (!fs.statSync(apiPath).isDirectory()) continue;
  const ctRoot = path.join(apiPath, "content-types");
  if (!fs.existsSync(ctRoot)) continue;

  const routesDir = path.join(apiPath, "routes");
  if (!fs.existsSync(routesDir)) fs.mkdirSync(routesDir, { recursive: true });

  const controllersDir = path.join(apiPath, "controllers");
  const servicesDir = path.join(apiPath, "services");

  for (const ctName of fs.readdirSync(ctRoot)) {
    const schemaPath = path.join(ctRoot, ctName, "schema.json");
    if (!fs.existsSync(schemaPath)) continue;
    const uid = `api::${apiName}.${ctName}`;

    const routePath = path.join(routesDir, `${ctName}.js`);
    const routeBody = `'use strict';

module.exports = require('@strapi/strapi').factories.createCoreRouter('${uid}');
`;
    if (writeIfChanged(routePath, routeBody)) {
      console.log("wrote", path.relative(path.join(__dirname, ".."), routePath));
    }

    const controllerPath = path.join(controllersDir, `${ctName}.ts`);
    const controllerBody = `/**
 * Core REST controller (generated). Do not remove — required by routes/${ctName}.js.
 */
import { factories } from "@strapi/strapi";

export default factories.createCoreController("${uid}");
`;
    if (!fs.existsSync(controllerPath)) {
      fs.mkdirSync(controllersDir, { recursive: true });
      fs.writeFileSync(controllerPath, controllerBody, "utf8");
      console.log("wrote", path.relative(path.join(__dirname, ".."), controllerPath));
    }

    const servicePath = path.join(servicesDir, `${ctName}.ts`);
    const serviceBody = `/**
 * Core service (generated). Do not remove — used by the core controller.
 */
import { factories } from "@strapi/strapi";

export default factories.createCoreService("${uid}");
`;
    if (!fs.existsSync(servicePath)) {
      fs.mkdirSync(servicesDir, { recursive: true });
      fs.writeFileSync(servicePath, serviceBody, "utf8");
      console.log("wrote", path.relative(path.join(__dirname, ".."), servicePath));
    }
  }
}
