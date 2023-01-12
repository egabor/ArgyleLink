# Argyle Link iOS

## Setting up the project

Before you build and run the project you need to set two configuration values ('API_KEY_ID' and 'API_KEY_SECRET') in the 'Shared.xcconfig'. If you miss this the app will run on a fatalError when these values are getting read.

After the packages are loaded you can run the project.

## Architecture

## Used libraries

- Resolver
- Logging (swift-log)

## Known bugs

- NOTICE: The API Reference Documentation doesn't talk about optional properties at all. It doesn't mark any property as optional, but based on the data the `logo_url` is optional. eg.: 'Randall County, Texas'
