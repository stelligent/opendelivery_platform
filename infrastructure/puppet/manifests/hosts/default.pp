node default {

	class { "java":       stage => pre  }
	class { "system":     stage => pre  }
	class { "passenger":  stage => main }
	class { 'mysql':      stage => main }

}