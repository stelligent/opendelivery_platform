node default {
  class { "params":     stage => pre  }
	class { "java":       stage => pre  }
	class { "system":     stage => pre  }
	class { "tomcat6":    stage => main }
	class { "postgresql": stage => main }
	class { "httpd":      stage => main }
}