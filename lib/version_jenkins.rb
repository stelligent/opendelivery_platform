jenkins_home = ARGV[0]

Dir.chdir("#{jenkins_home}") do
  system "git add  *.xml jobs/*/config.xml plugins/*.hpi .gitignore"
  system "git status --porcelain | grep '^ D ' | awk '{print $2;}' | xargs -r git rm"
  system "git commit -m 'Automated commit of jenkins configuration' -a"
  system "git push"
end
