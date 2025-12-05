# lovemod

**lovemod** is a LÖVE layer library for integrating modding support into LOVE projects. It allows you to create your own modding layer API for your project.

## How to use

To load a mod, simply load the mod's file contents and pass it to the argument of `lm.LoadMod()`.
That's pretty much it, it's your decision how the mod's module configuration, metadata and functions are structured.
To see an example, look into the `example` directory.

## API

```lua
lm.LoadMod(module: function, path: string, env: table): boolean, string -- Loads the mod from its module code
```
