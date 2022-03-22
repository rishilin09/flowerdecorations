# Flower Decorations

This project is providing flower decorations services through application for users and providing invoice for the same

# Project Description

Application will start from **main.dart** file since it is the **ROOT OF THE PROJECT**

**Assets** folder will contain *images* and *fonts* which will be used in application

This project is been divided within **lib** folder as

- lib
    - config
    - Models
    - Screens
        - Authentication
        - Home
    - Services
        - Invoice
    - SharedWidgets

1. **config :-** It contains all the styling elements which will be needed into application
2. **Models :-** It contains modal classes which will be used for storing values as their objects
3. **Screens :-** It contains dart files which will displaying screens for the application
4. **Services :-** It contains all the services which will be used with the application
5. **SharedWidgets :-** It contains widgets which will be used in more than one file
6. **Authentication :-** It contains files related to authentication i.e Login and Register
7. **Home :-** It contains files related to Home page
8. **Invoice :-** It contains invoice generating files

- **projectImports.dart** file will contain all the necessary importing files which will be required throughout the
  project. Rather than importing same package everytime in different file, **projectImports.dart** file will get
  imported which contains all the packages which every file requires.
