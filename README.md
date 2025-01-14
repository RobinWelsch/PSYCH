# PSYCH


This course - Psychological Statistics You Can Handle (PSYCH) - is meant to be paired with an Undergraduate Research Methods or Statistics course, with notes that could serve up to early career graduate students. It is meant to help teach students basic statistics using R in an interactive framework. We take open data and replicate the results (or discuss why sometimes we cannot replicate the results). Students interact with many packages throughout this course, with the main ones being the tidyverse (dplyr, tidyr, purrr, ggplot2), rstatix, and emmeans. 

This course does not cover Baysian Statistics.

This course was supported through the Society for the Improvement of Psychological Science (SIPS) Grants-In-Aid to Reduce Barriers to Improving Psychological Science.

This course is recommended to be run in RStudio. Please download R- https://www.r-project.org/ and RStudio - https://www.rstudio.com/ first.

This course requires the installation of the swirl package. Once RStudio has loaded, type the following into the console: 

    install.packages("swirl")
    
You can also directly install from github with the following code:

    library(swirl)
    install_course_github("RobinWelsch", "PSYCH")
    swirl()

## For Teachers

If you are a teacher/professor looking to use this course in your classroom, please follow the following instructions.

0) Create your own GitHub account.

1) Fork this repository by clicking the top right button that says "Fork". This will create a copy of the course under your username.

2) In each lesson, there is a customTests.R file. Inside each is a single Google Form link. You should update these google form links to google forms of your own. I keep a folder on my drive called PSYCH Form Collection that houses all of the forms. Create a new form, add any questions you want, but please ensure that you have the first question being an essay text box. At the top right, the three vertical dots says "Get pre-filled link". Choose that. In the form, type something in the text box ("Test"), but fill out no additional questions. Scroll to the bottom and click "Get Link" and then "Copy Link" on the bottom left. Your link will now look similar to the link within customTests.R , but will end with =Test. Delete the '=Test' piece of the link. The &entry.[numbers] piece is what points R to filling in the essay box with the information.

3) You can also find a walkthrough of this more at https://github.com/seankross/Google_Forms_Course install_course_github("seankross", "Google_Forms_Course").

4) As the ReadMe in that ^ course states, once you have set all of the links up, you can download and read the results of form submissions through swirlify::google_form_decode() on each .csv of the form. You should decide whether or not you want your students to use their full name when logging into swirl() or if you want to add a question in your Google Form asking them to provide this information to you.

5) These customTests.R files can be edited in your own GitHub multiple ways, depending on your comfort of GitHub. 

- You can edit directly within GitHub itself (navigate to the file, click the pencil, type in new link, commit changes).

- You can click the green "Code" button, and on the Local tab, click Download Zip. Open the Zip and place the folders in some place you won't lose it. Make the changes on your computer, and then you can navigate to each folder on GitHub and drag and drop the files into the folder to be replaced. Push the changes to the master branch.

- You could download GitHub Desktop, clone your repository on your computer, make changes on the file itself, and push these changes to origin. I do recommend the second option only because it will 

6) I would highly recommend 2 or 3, only because at the next step, you will need the whole course on your computer in order to create a .swc . 

6) Once you have completed these steps, follow the steps of http://swirlstats.com/swirlify/sharing.html to create a new .swc . (You'll need the swirlify package). Push the form changes + the new .swc to your fork of this repository.

4) Now, have students install_course_github("yourgithubname", "PSYCH"). 

### Future Plans

- Consider making the hints actually hint-y. Currently, all hints just give the answer.

- Always looking for edits and other helpful tips - both for the course itself and the Notes.R! 

- Look for collaborators! Are you interested in using this in your course? Can we A/B test to see if it helps? We'd love to publish on our course but need some testing to back it up, and would love for you to be a co-author on the manuscript!
