import { defineConfig } from "vite";
import gleam from "vite-gleam";
import { resolve } from "path";

const dirname = import.meta.dirname;

export default defineConfig({
  plugins: [
    gleam(),
  ],
  input: {
    main: resolve(dirname, "index.html"),
    raytracing: resolve(dirname, "raytracing.html"),
  },
  build: {
    outDir: "dist",
  },
});
