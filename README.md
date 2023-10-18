# fetch-script

# Installation
1. Clone this repository on the parent dir of you liferay-portal source dir path (../liferay-portal)

		git@github.com:lucasperj/fetch-script.git

# Usage
1. Go to liferay-portal/../fetch-script 
2. Type 

		fetch_pull_request.sh -h
    to see the usage manual
3. You can use a set of variables combinations to customize the script action 

   
		-r <repository>   Set repository name
		-i <gitid>        Set git ID
		-b <branch>       Set branch name
		-m                Set rebase flag to match your branch with master
		-t <file#name>    Set testFile#testName - [If you want to run a test]
		-a                Set ant-all flag if you want to build on top of the new branch

		Example: ./fetch_pull_request.sh -r <repo_name> -i <git_id> -b <branch_name> -m -t <testcase_file#testcase_name> -a

Ex Comb 1. Fetch a pull request, rebase the branch, built the bundle and run the test after everything is ready.
---
![example1](https://github.com/lucasperj/fetch-script/assets/52680028/2b51ff3f-bba7-40fa-9a3f-be39f00e4318)

Ex Comb 2. Fetch a pull request, rebase the branch and run the test right after(without ant all the branch).
---
![example2](https://github.com/lucasperj/fetch-script/assets/52680028/a2e90840-d065-414c-97f9-a1a3f0b69c59)

Ex 3. If you want to give up running the test due to some configuration you want to change.
---
![example3](https://github.com/lucasperj/fetch-script/assets/52680028/85959599-eeb8-48a3-800a-0d0cf50cc581)

