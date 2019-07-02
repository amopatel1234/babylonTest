# babylonTest

This project is used to demonstrate how I would go about architecting an iOS app, its uses MVVM-C with a heavy reliance on protocols for interface segerigration and allowing obejcts to be mocked in ordfer to test them.

## Note
When looking at the DataStore class please note that this is just meant to show where data would be persisted and in order to save time I chosse to use UserDfaults as my persistent store, however this is not what I would use in production, You should be able to see that you could change how the data is persisted, i.e. we could use CoreData or Realm, the two methods that are there are the ones that matter as they are exposed interface and that what the rest of the app communicates with.
