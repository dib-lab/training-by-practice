# training-by-practice
This is a Git hub repository for intial training on Bash commands and co-operation on github. The repository has 3 files:

1.  hg19.coding_subset.bed: This a bed file for coding genes of 3 human chromosomes. This file represents the input of required tasks. 
2.  main.sh: This is a bash script file. At the begining, I explain how I created the bed file. Then there is description of the required tasks
3.  README file: This is the file you are reading now.

# Manual of the github steps to work this out

1.  Fork the repository from the dib-lab page to your account
2.  clone the repo to your computer (exchange the word "USER" with you github username)

    `git clone https://github.com/USER/training-by-practice.git` 
      
    `cd training-by-practice`
3.  update the url of your remote github repo (I only need to do this on our super computer)

    `git remote set-url origin https://USER@github.com/USER/training-by-practice.git`
4.  Connect your local repo to the original remote github repo

    `git remote add DIB https://USER@github.com/dib-lab/training-by-practice.git`
5.  move to the template branch

    `git checkout -b template1 origin/template1`
6.  make your code changes to solve required tasks
7.  commit these changes to your remote template branch. Please do not add the output files to your commit

    `git add main.sh`

    `git commit -m "name tasks you finished"`
    
    `git push origin template1`
8.  make pull request from your github webpage. Make sure to change the branch to the template branch before making the pull request.
9.  When your pull request is accepted, more tasks will be added. You need to pull these new changes to your local repo. Make sure you are in the tamplate branch. Then you can repeat the steps 6-8 and so on 

   `git checkout template1`
   
   `git pull origin template1`

