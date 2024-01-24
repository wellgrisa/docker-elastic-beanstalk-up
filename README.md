# docker-elastic-beanstalk-up

TL;DR;

The best readme of this project would be reading the two articles which are based on it:

- [Automate (CI/CD) and Reverse Proxy a Docker Elastic Beanstalk Up with GitHub Actions](https://medium.com/@wellington.grisa/automate-ci-cd-and-reverse-proxy-a-docker-elastic-beanstalk-up-with-github-actions-346f15e28180)
- [Using Lerna with GitHub Actions to Deploy a versioned Full-stack Application to Elastic Beanstalk](https://medium.com/@wellington.grisa/using-lerna-with-github-actions-to-deploy-a-versioned-full-stack-application-to-elastic-beanstalk-12ec99e15660)

This project started from the need of helping other developers like me who got overwhelmed by so many articles (old and new ones) which were always incomplete in terms of the big picture when there is a need to make your application available for the World (e.g.: hey relatives, access this url to see what I've been playing).

The idea of using Elastic Beanstalk is truly to have something set up in your behalf, where you don't want to worry and configure an EC2 instance, Target Groups, VPCs, Cloudwatch, and some of other AWS services. But, when you start chasing how to make it work in our current dev lives, things are not quite easy to find.

Thus, this project has come, so over here you can check a full-stack application (split in front-end using Remix and a back-end using node) using lerna as tooling and take a good use of GitHub Actions since the checks (testing), version (tag), building images and THE so desired deploy.

The best way to understand the whole picture is really reading the step-by-step created in the articles where it's been well detailed.

But in a nutshell, the idea is really forking this project or just taking it as a base, change the configurable secrets, keys and roles pointing to your AWS account and worry only with your code.

This is definitely the main motivation of this project, to make possible to some developer who is not experienced in AWS and DevOps to be able to worry only with the use cases, the core of your system, being screens or just an api (or both).

Have fun.
