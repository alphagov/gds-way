---
title: GDS Python Style Guide
last_reviewed_on: 2018-11-13
review_in: 6 months
---

## GDS Python Style Guide


### Line length <= 120

PEP-0008 dictates a preferred line length of <= 79. This is is a hangover from developing in a Unix terminal window.
The vast majority of developers are now using an IDE which can handle a greater line length comfortably.
Couple this with the fact that much of the time GDS developers are coding web apps and have to deal with nested `JSON`
objects, ORM model definitions/ queries, and error/ url strings and this convention begins to show its age.

```
# Don't do

if not models.Address.query(
    models.Address.street_address_line_1
    == user['address']['street_address_line_1']
):
    pass


# Do

if not models.Address.query(models.Address.street_address_line_1 == user['address']['street_address_line_1']):
    pass
```
