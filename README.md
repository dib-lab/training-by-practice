# training-by-practice
Git hub repository for intial training on Bash commands and co-operation on github.

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
7.  make pull request from your github webpage. Make sure to change the branch to the template branch before making the pull request 

