# README


This application is a mock store called Root & Branch.

Root & Branch sells socially responsible goods.

![root-and-branch](https://s3-us-west-2.amazonaws.com/turingmentorship/root-and-branch.gif)

The live app can be accessed at https://root-and-branch.herokuapp.com/

To run locally:
```
git clone git@github.com:epintozzi/root_and_branch.git
rake db:create db:migrate db:seed
rails s
```

The test suite is uses rspec and capybara: `rspec`

This app is written in Rails v5.0.0.1
