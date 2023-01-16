# Argyle Link iOS

## Requirements

- Minimum iOS version: 16.0

## Setting up the project

- Wait for the packages to be loaded.
- Set the configuration values in the [Shared.xcconfig](ArgyleLink/Configuration/Shared.xcconfig) file.
    - **API_KEY_ID**: The value which is in the task description.
    - **API_KEY_SECRET**: The value that you received privately.

❗️**IMPORTANT**: If you miss setting these values the app will run on a fatalError (to remind you) when the values are getting read.

## Architecture

MVVM architecture is used in the project along with SwiftUI and Combine. For shared/reusable business logic use cases were used.

## Used libraries

- Resolver
- Logging (swift-log)
- SwiftLint

## Known bugs

- NOTICE: The API Reference Documentation doesn't talk about optional properties at all. It doesn't mark any property as optional, but based on the data the `logo_url` is optional. eg.: 'Randall County, Texas'
