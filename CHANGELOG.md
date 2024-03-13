# Changelog

## [(not yet deployed) 2.0](https://github.com/uclibs/aaec/tree/HEAD)

[Full Changelog](https://github.com/uclibs/aaec/compare/fourth-deploy...HEAD)

**Breaking changes:**

- Remove scripts/start-local.sh [\#223](https://github.com/uclibs/aaec/issues/223)
- 404 errors for CSS files in QA deployed version [\#217](https://github.com/uclibs/aaec/issues/217)
- Update capistrano/deploy scripts for Puma daemon deprecation [\#214](https://github.com/uclibs/aaec/issues/214)
- Unable to deploy QA branch [\#212](https://github.com/uclibs/aaec/issues/212)
- Update Pagy - Dependabot failing [\#202](https://github.com/uclibs/aaec/issues/202)
- Upgrade ruby, rails, and gems [\#168](https://github.com/uclibs/aaec/issues/168)
- QA : certificate verify failed after submitting publication [\#162](https://github.com/uclibs/aaec/issues/162)
- Upgrade to ruby 3.0.x and rails 6.0.x [\#157](https://github.com/uclibs/aaec/issues/157)
- Bundle-audit: 3/9/22 [\#151](https://github.com/uclibs/aaec/issues/151)
- Add and run brakeman \(epic\) [\#145](https://github.com/uclibs/aaec/issues/145)
- Bundle Update [\#137](https://github.com/uclibs/aaec/issues/137)
- Change default branch from master to main [\#132](https://github.com/uclibs/aaec/issues/132)

**Fixed bugs:**

- Non-working hamburger menu visible on mobile view [\#228](https://github.com/uclibs/aaec/issues/228)
- Update header/footer UI to match website [\#177](https://github.com/uclibs/aaec/issues/177)
- Update tests to run on latest Chrome version [\#172](https://github.com/uclibs/aaec/issues/172)
- Correct HTML in email replies [\#165](https://github.com/uclibs/aaec/issues/165)
- Coveralls integration is broken [\#164](https://github.com/uclibs/aaec/issues/164)
- Icons Missing in Footer and other areas [\#161](https://github.com/uclibs/aaec/issues/161)
- Fix Circle-CI [\#141](https://github.com/uclibs/aaec/issues/141)
- Implement Melissa's suggested changes for the 2020 publication year [\#136](https://github.com/uclibs/aaec/issues/136)

**Security fixes:**

- Create .github/dependabot.yml file to automatically create PRs [\#188](https://github.com/uclibs/aaec/issues/188)
- Add brakeman and bundler-audit to CI [\#155](https://github.com/uclibs/aaec/issues/155)
- Brakeman: Dynamic Render Path vulnerability [\#150](https://github.com/uclibs/aaec/issues/150)
- Brakeman: Remote Code Execution vulnerability [\#149](https://github.com/uclibs/aaec/issues/149)
- Brakeman: Format Validation vulnerability [\#148](https://github.com/uclibs/aaec/issues/148)
- Brakeman: FileAccess vulnerability [\#147](https://github.com/uclibs/aaec/issues/147)
- Add and run bundler-audit [\#146](https://github.com/uclibs/aaec/issues/146)

**Closed issues:**

- Add interactive confirmation check for deploy [\#218](https://github.com/uclibs/aaec/issues/218)
- Add Github Templates [\#170](https://github.com/uclibs/aaec/issues/170)
- Install Restart and Stop Application [\#166](https://github.com/uclibs/aaec/issues/166)
- Remove start-aaec.sh script [\#160](https://github.com/uclibs/aaec/issues/160)
- Upgrade to ruby 3.1.x and rails 6.1.x [\#159](https://github.com/uclibs/aaec/issues/159)
- Update Capistrano config to work with RVM [\#156](https://github.com/uclibs/aaec/issues/156)
- Increase test coverage [\#131](https://github.com/uclibs/aaec/issues/131)
- Monitor that the application is up [\#90](https://github.com/uclibs/aaec/issues/90)

**Merged pull requests:**

- 217 feature branch error pages css fix [\#235](https://github.com/uclibs/aaec/pull/235) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 228 - fixed hamburger drop-down menu \(broken data-toggle="collapse" tag\) [\#234](https://github.com/uclibs/aaec/pull/234) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 162 fix 500 error on submission [\#233](https://github.com/uclibs/aaec/pull/233) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Bump selenium-webdriver from 4.12.0 to 4.13.1 [\#232](https://github.com/uclibs/aaec/pull/232) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump rubocop from 1.56.3 to 1.56.4 [\#231](https://github.com/uclibs/aaec/pull/231) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump pagy from 6.0.4 to 6.1.0 [\#230](https://github.com/uclibs/aaec/pull/230) ([dependabot[bot]](https://github.com/apps/dependabot))
- 217 part 3: fix 404 error page content [\#229](https://github.com/uclibs/aaec/pull/229) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Add confirmation check to deploy [\#225](https://github.com/uclibs/aaec/pull/225) ([crowesn](https://github.com/crowesn))
- 223-remove scripts/start\_local.sh [\#224](https://github.com/uclibs/aaec/pull/224) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 160 remove start aaecsh script [\#222](https://github.com/uclibs/aaec/pull/222) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Bump bootstrap from 4.4.1 to 5.3.1 [\#221](https://github.com/uclibs/aaec/pull/221) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump net-smtp from 0.3.3 to 0.4.0 [\#220](https://github.com/uclibs/aaec/pull/220) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puma from 6.3.1 to 6.4.0 [\#219](https://github.com/uclibs/aaec/pull/219) ([dependabot[bot]](https://github.com/apps/dependabot))
- Removes Webpacker. [\#213](https://github.com/uclibs/aaec/pull/213) ([scherztc](https://github.com/scherztc))
- Bump spring-watcher-listen and spring [\#209](https://github.com/uclibs/aaec/pull/209) ([dependabot[bot]](https://github.com/apps/dependabot))
- Adds platform x86\_64 to Gemfile.lock [\#206](https://github.com/uclibs/aaec/pull/206) ([scherztc](https://github.com/scherztc))
- 131 added tests for channels, jobs, and publications\_helper [\#205](https://github.com/uclibs/aaec/pull/205) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 202: updated pagy to 6.0.4, updated config/initializers/pagy file [\#203](https://github.com/uclibs/aaec/pull/203) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Footer updates partial fix for 171 [\#201](https://github.com/uclibs/aaec/pull/201) ([haitzlm](https://github.com/haitzlm))
- Bump webpack from 4.46.0 to 5.88.2 [\#200](https://github.com/uclibs/aaec/pull/200) ([dependabot[bot]](https://github.com/apps/dependabot))
- fixes \#161-fontawesome icons [\#199](https://github.com/uclibs/aaec/pull/199) ([haitzlm](https://github.com/haitzlm))
- Bump capistrano-bundler from 1.6.0 to 2.1.0 [\#198](https://github.com/uclibs/aaec/pull/198) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump @rails/webpacker from 5.4.3 to 5.4.4 [\#197](https://github.com/uclibs/aaec/pull/197) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump webpack-dev-server from 3.11.3 to 4.15.1 [\#195](https://github.com/uclibs/aaec/pull/195) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump sass-rails from 5.1.0 to 6.0.0 [\#193](https://github.com/uclibs/aaec/pull/193) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump listen from 3.0.8 to 3.8.0 [\#192](https://github.com/uclibs/aaec/pull/192) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump webpack-cli from 3.3.12 to 4.10.0 [\#191](https://github.com/uclibs/aaec/pull/191) ([dependabot[bot]](https://github.com/apps/dependabot))
- Create new dependabot.yml file for security updates [\#189](https://github.com/uclibs/aaec/pull/189) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Bump json5 from 1.0.1 to 1.0.2 [\#187](https://github.com/uclibs/aaec/pull/187) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump loader-utils from 1.4.0 to 1.4.2 [\#186](https://github.com/uclibs/aaec/pull/186) ([dependabot[bot]](https://github.com/apps/dependabot))
- added brakeman and bundler-audit to CI, move brakeman gem to dev/test [\#184](https://github.com/uclibs/aaec/pull/184) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 146: added bundler-audit, bumped puma from 3.12.4 to 6.3.1 [\#183](https://github.com/uclibs/aaec/pull/183) ([Janell-Huyck](https://github.com/Janell-Huyck))
- changed spec\_helper to have random seed for tests [\#182](https://github.com/uclibs/aaec/pull/182) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 150 resolved dynamic-render-path-vulnerability [\#181](https://github.com/uclibs/aaec/pull/181) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 149 fixed remote-code-execution vulnerability, added tests for new code [\#180](https://github.com/uclibs/aaec/pull/180) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 148 format validation vulnerability [\#179](https://github.com/uclibs/aaec/pull/179) ([Janell-Huyck](https://github.com/Janell-Huyck))
- 147 file access vulnerability fix [\#176](https://github.com/uclibs/aaec/pull/176) ([Janell-Huyck](https://github.com/Janell-Huyck))
- added brakeman gem ~\> 6.0. Ran bundle install and bundle update [\#175](https://github.com/uclibs/aaec/pull/175) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Update Ruby to 3.2.2 for everything and Rails to 6.1.7.6 [\#174](https://github.com/uclibs/aaec/pull/174) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Update selenium-webdriver to version 4.11.0 or higher [\#173](https://github.com/uclibs/aaec/pull/173) ([Janell-Huyck](https://github.com/Janell-Huyck))
- add github issue\_template & pull\_request\_template [\#171](https://github.com/uclibs/aaec/pull/171) ([Janell-Huyck](https://github.com/Janell-Huyck))
- Removed unnecessaary markup from html emails [\#167](https://github.com/uclibs/aaec/pull/167) ([haitzlm](https://github.com/haitzlm))
- Upgrade to ruby 3.0.5 rails 6.1.x [\#163](https://github.com/uclibs/aaec/pull/163) ([crowesn](https://github.com/crowesn))
- Update rails & ruby [\#158](https://github.com/uclibs/aaec/pull/158) ([bsp3ars](https://github.com/bsp3ars))
- Bump addressable from 2.7.0 to 2.8.0 [\#139](https://github.com/uclibs/aaec/pull/139) ([dependabot[bot]](https://github.com/apps/dependabot))

## [1.1](https://github.com/uclibs/aaec/tree/fourth-deploy) (2021-06-04)

[Full Changelog](https://github.com/uclibs/aaec/compare/third-deploy...fourth-deploy)

**Breaking changes:**

- Bundle update [\#126](https://github.com/uclibs/aaec/issues/126)
- Integrate coveralls reporting with circleci builds [\#124](https://github.com/uclibs/aaec/issues/124)

**Merged pull requests:**

- Changes for 2020 [\#138](https://github.com/uclibs/aaec/pull/138) ([hortongn](https://github.com/hortongn))
- Integrate Coveralls with CircleCI [\#130](https://github.com/uclibs/aaec/pull/130) ([harithavytla](https://github.com/harithavytla))

## [1.0](https://github.com/uclibs/aaec/tree/third-deploy) (2020-09-10)

[Full Changelog](https://github.com/uclibs/aaec/compare/second-deploy...third-deploy)

**Breaking changes:**

- Bundle update [\#111](https://github.com/uclibs/aaec/issues/111)
- Change submission deadline [\#97](https://github.com/uclibs/aaec/issues/97)
- Configure Capistrano for production deploy [\#74](https://github.com/uclibs/aaec/issues/74)
- Allow logged in user to export content to CSV [\#43](https://github.com/uclibs/aaec/issues/43)

**Implemented enhancements:**

- Refactor Author Input [\#84](https://github.com/uclibs/aaec/issues/84)

**Fixed bugs:**

- Fix "closed" page and manager access [\#123](https://github.com/uclibs/aaec/issues/123)
- Show Page in Production is the 404 page \(admin\) [\#122](https://github.com/uclibs/aaec/issues/122)
- CSV download links don't work if the rails root is set [\#117](https://github.com/uclibs/aaec/issues/117)
- Capistrano deploy hangs on libapps2 after starting puma [\#103](https://github.com/uclibs/aaec/issues/103)
- Production site doesn't run properly under http [\#100](https://github.com/uclibs/aaec/issues/100)
- Production site is throwing errors because mail service isn't running [\#99](https://github.com/uclibs/aaec/issues/99)
- Only redirect Puma output if app is in production mode [\#82](https://github.com/uclibs/aaec/issues/82)
- Fix the uglifier problem [\#72](https://github.com/uclibs/aaec/issues/72)

**Closed issues:**

- Deploy latest changes [\#115](https://github.com/uclibs/aaec/issues/115)
- Remaining server changes  [\#105](https://github.com/uclibs/aaec/issues/105)
- Replace footer [\#104](https://github.com/uclibs/aaec/issues/104)
- Change submission email text [\#98](https://github.com/uclibs/aaec/issues/98)
- Bundle update [\#96](https://github.com/uclibs/aaec/issues/96)
- Clarify requirements for generating citations [\#92](https://github.com/uclibs/aaec/issues/92)
- Dockerize the project [\#88](https://github.com/uclibs/aaec/issues/88)
- Deploy app to production server [\#79](https://github.com/uclibs/aaec/issues/79)
- Get app running in production mode [\#52](https://github.com/uclibs/aaec/issues/52)
- Header tweaks [\#51](https://github.com/uclibs/aaec/issues/51)
- Protect the form from spam [\#10](https://github.com/uclibs/aaec/issues/10)

**Merged pull requests:**

- bundle update [\#127](https://github.com/uclibs/aaec/pull/127) ([harithavytla](https://github.com/harithavytla))
- 123/closed page access [\#125](https://github.com/uclibs/aaec/pull/125) ([bsp3ars](https://github.com/bsp3ars))
- Citations - 1: Display citations in MLA. Has edit button on citation page [\#121](https://github.com/uclibs/aaec/pull/121) ([bsp3ars](https://github.com/bsp3ars))
- Update form deadline to July 15, 2020 [\#120](https://github.com/uclibs/aaec/pull/120) ([hortongn](https://github.com/hortongn))
- Fix routes for CSV [\#119](https://github.com/uclibs/aaec/pull/119) ([bsp3ars](https://github.com/bsp3ars))
- Bump rack from 2.2.2 to 2.2.3 [\#118](https://github.com/uclibs/aaec/pull/118) ([dependabot[bot]](https://github.com/apps/dependabot))
- Allow capfile to be used with all capistrano 3.x versions [\#116](https://github.com/uclibs/aaec/pull/116) ([hortongn](https://github.com/hortongn))
- Bundle update 6/11/2020 [\#114](https://github.com/uclibs/aaec/pull/114) ([bsp3ars](https://github.com/bsp3ars))
- Bump websocket-extensions from 0.1.4 to 0.1.5 [\#112](https://github.com/uclibs/aaec/pull/112) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump nokogiri from 1.10.7 to 1.10.9 [\#109](https://github.com/uclibs/aaec/pull/109) ([dependabot[bot]](https://github.com/apps/dependabot))
- Deploy to libappstest instead of aramis [\#108](https://github.com/uclibs/aaec/pull/108) ([hortongn](https://github.com/hortongn))
- Replace footer [\#106](https://github.com/uclibs/aaec/pull/106) ([bsp3ars](https://github.com/bsp3ars))
- Bundle Update, Deadline & Email [\#101](https://github.com/uclibs/aaec/pull/101) ([bsp3ars](https://github.com/bsp3ars))
- \(WIP\) CSV Export [\#95](https://github.com/uclibs/aaec/pull/95) ([bsp3ars](https://github.com/bsp3ars))
- Implement capistrano for qa and production [\#94](https://github.com/uclibs/aaec/pull/94) ([bsp3ars](https://github.com/bsp3ars))
- Add script to start application if not already running [\#93](https://github.com/uclibs/aaec/pull/93) ([hortongn](https://github.com/hortongn))
- Add Docker support [\#91](https://github.com/uclibs/aaec/pull/91) ([bsp3ars](https://github.com/bsp3ars))
- Refactor multi-author [\#86](https://github.com/uclibs/aaec/pull/86) ([bsp3ars](https://github.com/bsp3ars))
- Only redirect Puma stdout for production [\#85](https://github.com/uclibs/aaec/pull/85) ([hortongn](https://github.com/hortongn))
- 51/header changes [\#83](https://github.com/uclibs/aaec/pull/83) ([bsp3ars](https://github.com/bsp3ars))
- Required changes for production [\#70](https://github.com/uclibs/aaec/pull/70) ([hortongn](https://github.com/hortongn))

## [0.3](https://github.com/uclibs/aaec/tree/second-deploy) (2020-03-09)

[Full Changelog](https://github.com/uclibs/aaec/compare/first-deploy...second-deploy)

**Breaking changes:**

- Email header changes [\#71](https://github.com/uclibs/aaec/issues/71)
- Follow Up 2/19/2020 [\#63](https://github.com/uclibs/aaec/issues/63)
- Add other college field [\#57](https://github.com/uclibs/aaec/issues/57)
- Add remaining Publication types [\#55](https://github.com/uclibs/aaec/issues/55)
- Implement admin user [\#31](https://github.com/uclibs/aaec/issues/31)
- Prevent form from being submitted after the deadline [\#7](https://github.com/uclibs/aaec/issues/7)

**Implemented enhancements:**

- Implement requested changes from client [\#80](https://github.com/uclibs/aaec/issues/80)
- Publication show pages should link back to /publications [\#61](https://github.com/uclibs/aaec/issues/61)
- Publication should show submitter information [\#59](https://github.com/uclibs/aaec/issues/59)
- Allow users to confirm they are finished [\#41](https://github.com/uclibs/aaec/issues/41)

**Closed issues:**

- Set a management username and password [\#78](https://github.com/uclibs/aaec/issues/78)
- Add content to footer [\#68](https://github.com/uclibs/aaec/issues/68)
- Spell Check Site [\#67](https://github.com/uclibs/aaec/issues/67)
- Clean up publication view [\#58](https://github.com/uclibs/aaec/issues/58)
- Follow-up from meeting w/ Melissa [\#54](https://github.com/uclibs/aaec/issues/54)
- Add instructions to the /publications [\#46](https://github.com/uclibs/aaec/issues/46)
- Change label for new publication form colleges checkboxes [\#42](https://github.com/uclibs/aaec/issues/42)
- Submitters new page should have a "Next" button [\#38](https://github.com/uclibs/aaec/issues/38)
- Implement an Admin Panel [\#23](https://github.com/uclibs/aaec/issues/23)
- Stylize the website [\#22](https://github.com/uclibs/aaec/issues/22)

**Merged pull requests:**

- 80/requested changes [\#81](https://github.com/uclibs/aaec/pull/81) ([bsp3ars](https://github.com/bsp3ars))
- Change email subject and receivers [\#75](https://github.com/uclibs/aaec/pull/75) ([hortongn](https://github.com/hortongn))
- Update footer [\#73](https://github.com/uclibs/aaec/pull/73) ([bsp3ars](https://github.com/bsp3ars))
- 55/add remaining types [\#69](https://github.com/uclibs/aaec/pull/69) ([bsp3ars](https://github.com/bsp3ars))
- Change links and fix JS [\#66](https://github.com/uclibs/aaec/pull/66) ([bsp3ars](https://github.com/bsp3ars))
- Add submitter info on view pages [\#65](https://github.com/uclibs/aaec/pull/65) ([bsp3ars](https://github.com/bsp3ars))
- 63/follow up [\#64](https://github.com/uclibs/aaec/pull/64) ([bsp3ars](https://github.com/bsp3ars))
- Implement other\_college field [\#62](https://github.com/uclibs/aaec/pull/62) ([bsp3ars](https://github.com/bsp3ars))
- Update publication view [\#60](https://github.com/uclibs/aaec/pull/60) ([bsp3ars](https://github.com/bsp3ars))
- 54/follow up meeting [\#56](https://github.com/uclibs/aaec/pull/56) ([bsp3ars](https://github.com/bsp3ars))
- Implement deadline [\#53](https://github.com/uclibs/aaec/pull/53) ([bsp3ars](https://github.com/bsp3ars))

## [0.2](https://github.com/uclibs/aaec/tree/first-deploy) (2020-02-07)

[Full Changelog](https://github.com/uclibs/aaec/compare/22e6d7151e144dcee1c56ed9418bc1d40aadd080...first-deploy)

**Breaking changes:**

- Limit the number of each publication type to 3 [\#39](https://github.com/uclibs/aaec/issues/39)
- Disable \#destroy for submitters [\#30](https://github.com/uclibs/aaec/issues/30)
- Send users to publications show page after entries [\#28](https://github.com/uclibs/aaec/issues/28)
- Send emails after form is submitted [\#6](https://github.com/uclibs/aaec/issues/6)
- Add the Publication Information section to the submission form [\#4](https://github.com/uclibs/aaec/issues/4)
- Create a form for collecting the submitter's contact info [\#3](https://github.com/uclibs/aaec/issues/3)
- Implement mailer [\#48](https://github.com/uclibs/aaec/pull/48) ([bsp3ars](https://github.com/bsp3ars))

**Implemented enhancements:**

- Allow for multiple publication authors [\#34](https://github.com/uclibs/aaec/issues/34)
- Publications index page should show all publications [\#29](https://github.com/uclibs/aaec/issues/29)
- List submitter details on the publications index page [\#27](https://github.com/uclibs/aaec/issues/27)
- Add the Instructions section to the form [\#5](https://github.com/uclibs/aaec/issues/5)
- Create Rails app and add standard gems [\#1](https://github.com/uclibs/aaec/issues/1)

**Fixed bugs:**

- Check submitter dropdown [\#37](https://github.com/uclibs/aaec/issues/37)
- Don't default to the first college in the select list [\#33](https://github.com/uclibs/aaec/issues/33)

**Closed issues:**

- Change labels on submitters form [\#35](https://github.com/uclibs/aaec/issues/35)
- Change title of new submitters page [\#32](https://github.com/uclibs/aaec/issues/32)
- Provide visual cues for form entry [\#26](https://github.com/uclibs/aaec/issues/26)
- Make Authors multi-valued [\#25](https://github.com/uclibs/aaec/issues/25)
- Allow submissions to be edited [\#11](https://github.com/uclibs/aaec/issues/11)
- Deploy application [\#9](https://github.com/uclibs/aaec/issues/9)
- Add standard files [\#2](https://github.com/uclibs/aaec/issues/2)

**Merged pull requests:**

- Implement UC header and footer [\#50](https://github.com/uclibs/aaec/pull/50) ([bsp3ars](https://github.com/bsp3ars))
- Add Admin features [\#49](https://github.com/uclibs/aaec/pull/49) ([bsp3ars](https://github.com/bsp3ars))
- Add capistrano support [\#47](https://github.com/uclibs/aaec/pull/47) ([bsp3ars](https://github.com/bsp3ars))
- 27/publication index [\#45](https://github.com/uclibs/aaec/pull/45) ([bsp3ars](https://github.com/bsp3ars))
- Make author fields multi-valued [\#44](https://github.com/uclibs/aaec/pull/44) ([bsp3ars](https://github.com/bsp3ars))
- Fixes dropdown, and adds prompt for college [\#40](https://github.com/uclibs/aaec/pull/40) ([bsp3ars](https://github.com/bsp3ars))
- Implement bootstrap sitewide [\#36](https://github.com/uclibs/aaec/pull/36) ([bsp3ars](https://github.com/bsp3ars))
- Add instruction page [\#24](https://github.com/uclibs/aaec/pull/24) ([bsp3ars](https://github.com/bsp3ars))
- \#4/publication information [\#21](https://github.com/uclibs/aaec/pull/21) ([bsp3ars](https://github.com/bsp3ars))
- Create Submitter form [\#20](https://github.com/uclibs/aaec/pull/20) ([bsp3ars](https://github.com/bsp3ars))
- \#2/standard files [\#18](https://github.com/uclibs/aaec/pull/18) ([bsp3ars](https://github.com/bsp3ars))
- Setup Circle-CI [\#17](https://github.com/uclibs/aaec/pull/17) ([bsp3ars](https://github.com/bsp3ars))
- Add boostrap gem [\#16](https://github.com/uclibs/aaec/pull/16) ([bsp3ars](https://github.com/bsp3ars))
- Add dotenv gem [\#15](https://github.com/uclibs/aaec/pull/15) ([bsp3ars](https://github.com/bsp3ars))
- Add and configure coveralls [\#14](https://github.com/uclibs/aaec/pull/14) ([bsp3ars](https://github.com/bsp3ars))
- Add and configure rubocop gem [\#13](https://github.com/uclibs/aaec/pull/13) ([bsp3ars](https://github.com/bsp3ars))
- Add and configure rspec [\#12](https://github.com/uclibs/aaec/pull/12) ([bsp3ars](https://github.com/bsp3ars))

## [0.1] - Creation of Project (12/4/2019)

\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
