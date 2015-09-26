# ABLocalize
Some localization tricks to support multiple targets

# Usage

Just

```
pod 'ABLocalize'
```

Assign `ABLocalizeTag` one of values from `Build Settings` -> `Preprocessor Macros` like this:

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef APP1
    ABLocalizeTag = @"APP1";
#elif defined(APP2)
	ABLocalizeTag = @"APP2";
#elif defined(APP3)
	ABLocalizeTag = @"APP3";
#else
    #error One of macros APP1, APP2, APP3 should be defined!
#endif

	// …
}
```

And you can tag all your localization string you want to depend on target:

```
"LOGIN_INVITATION#APP1" = "Welcome to Foo App";
"LOGIN_INVITATION#APP2" = "Welcome to Bar App";
"LOGIN_INVITATION#APP3" = "Welcome to Lol App";
```

Even in `de.lproj/Main.strings` for `Main.stroyboard` localization:

```
"I3Z-Vv-9QS.text" = "Herzlich Willkommen";
"I3Z-Vv-9QS.text#APP3" = "¯\_(ツ)_/¯";
```

App will try to get tagged version, if not exist - then get common version.

# Contribution

Feel free to discuss, pull request and [tweet](https://twitter.com/k06a)
