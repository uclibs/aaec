Scenarios:

Scenario 1 - access_outside_open_dates
  Admins can access anything regardless of dates
  Submitters are redirected to the closed page
  
Scenario 2 - access_invalid_authenticity (within open dates, having an invalid authenticity token)
  Admins are redirected to admin login page
  Submitters are redirected to root page

Scenario 3 - missing_session_id

Scenario 1 & 2 - access_outside_open_dates_invalid_authenticity
  Admins with invalid authenticity token is redirected to admin login page
  Submitters are redirected to the closed page

Scenario 1 & 3
Scenario 2 & 3

Scenario 1, 2, and 3
