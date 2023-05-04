module.exports = {
  packagerConfig: {},
  rebuildConfig: {},
  makers: [
    {
      name: "@electron-forge/maker-squirrel",
      config: {
        authors: "FYP-A15",
      },
    },
    {
      name: "@electron-forge/maker-zip",
      platforms: ["darwin", "linux"],
    },
    {
      name: "@electron-forge/maker-deb",
      config: {
        maintainer: "FYP-A15",
      },
    },
    {
      name: "@electron-forge/maker-rpm",
      config: {},
    },
  ],
};
