##
## Properties Override
##

    #
    # Specify where to get the overridden properties. Updates should not be made
    # on this file but on the overridden version of this file.
    #
    include-and-override=portlet-service-ext.properties

##
## Build
##

    build.namespace=${portletShortName}
    build.number=${buildNumber}
    build.date=${currentTimeMillis?c}

##
## Spring
##

    spring.configs=\
        META-INF/data-source-spring.xml,\
        META-INF/portlet-spring.xml,\
        META-INF/ext-spring.xml

    #
    # Set the bean name for the Liferay data source.
    #
    spring.hibernate.data.source=liferayDataSource

    #
    # Set the bean name for the Liferay session factory.
    #
    spring.hibernate.session.factory=&liferaySessionFactory

##
## Hibernate
##

    #
    # Input a list of comma delimited Hibernate configurations.
    #
    hibernate.configs=\
        META-INF/portlet-hbm.xml,\
        META-INF/ext-hbm.xml

    #
    # Use the Liferay SQL dialect because it will automatically detect the proper
    # SQL dialect based on your connection URL.
    #
    hibernate.dialect=${springHibernatePackage}.DynamicDialect

    #
    # Set the Hibernate connection release mode. You should not modify this
    # unless you know what you're doing. The default setting works best for
    # Spring managed transactions. See the method buildSessionFactory in class
    # org.springframework.orm.hibernate3.LocalSessionFactoryBean and search for
    # the phrase "on_close" to understand how this works.
    #
    #hibernate.connection.release_mode=on_close

    #
    # Set the Hibernate cache provider. Ehcache is recommended in a clustered
    # environment. See the property "net.sf.ehcache.configurationResourceName"
    # for detailed configuration.
    #
    hibernate.cache.provider_class=com.liferay.util.dao.hibernate.EhCacheProvider
    #hibernate.cache.provider_class=net.sf.hibernate.cache.HashtableCacheProvider

    #
    # This property is used if Hibernate is configured to use Ehcache's
    # cache provider.
    #
    net.sf.ehcache.configurationResourceName=/ehcache/hibernate.xml

    #
    # Set other Hibernate cache settings.
    #
    hibernate.cache.use_query_cache=true
    hibernate.cache.use_second_level_cache=true
    hibernate.cache.use_minimal_puts=true
    hibernate.cache.use_structured_entries=false

    #
    # Uncomment these properties to disable Hibernate caching.
    #
    #hibernate.cache.provider_class=org.hibernate.cache.NoCacheProvider
    #hibernate.cache.use_query_cache=false
    #hibernate.cache.use_second_level_cache=false

    #
    # Set the JDBC batch size to improve performance. However, if you're using
    # Oracle 9i, you must set the batch size to 0 as a workaround for a hanging
    # bug in the Oracle driver. See http://support.liferay.com/browse/LEP-1234
    # for more information.
    #
    hibernate.jdbc.batch_size=20
    #hibernate.jdbc.batch_size=0

    #
    # Set other miscellaneous Hibernate properties.
    #
    hibernate.jdbc.use_scrollable_resultset=true
    hibernate.bytecode.use_reflection_optimizer=true
    hibernate.show_sql=false

    #
    # Use the classic query factory until WebLogic and Hibernate 3 can get
    # along. See http://www.hibernate.org/250.html#A23 for more information.
    #
    hibernate.query.factory_class=org.hibernate.hql.classic.ClassicQueryTranslatorFactory

##
## Value Object
##

    value.object.finder.cache.enabled=true