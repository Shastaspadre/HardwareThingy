# Refactoring for testability

- The premise is that we have inherited an app and would like to refactor it for testability to be able to assure ourselves that we can rely on the app once refactored. 
- It works interactively – OK, you may have to suspend some amount of disbelief at the works part – but we'd feel a lot less traumatized with a set of unit tests that prove it really does work and that the refactored code delivers the behavior the original is intended to provide.
- The app is intended to connect to hypothetical Bluetooth Low Energy hardware, tracking the several states the HardwareThingy goes through as part of connection, displaying those states as they change and the eventual overall result in the app's only view.
