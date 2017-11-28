package cdv.infrastructure.metrics;

import com.codahale.metrics.JvmAttributeGaugeSet;
import com.codahale.metrics.MetricFilter;
import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.graphite.Graphite;
import com.codahale.metrics.graphite.GraphiteReporter;
import com.codahale.metrics.jvm.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.lang.management.ManagementFactory;
import java.net.InetSocketAddress;
import java.util.concurrent.TimeUnit;

/**
 * Sample configuration that demonstrate Metrics library usage
 *
 * @author Dmitry Kulga
 *         28.11.2017 09:49
 */
@Configuration
@EnableScheduling
@EnableAutoConfiguration
public class MetricsConfiguration {

    @Value("${app.graphite.host}")
    private String graphiteHost;

    @Value("${app.graphite.port}")
    private int graphitePort;

    @PostConstruct
    public void init() {
        getGraphiteReporter().start(5, TimeUnit.SECONDS);
    }

    @PreDestroy
    public void destroy() {
        getGraphiteReporter().stop();
    }

    @Bean
    public MetricRegistry getMetricsRegistry() {
        MetricRegistry registry = new MetricRegistry();
        registry.register("jvm.attributes", new JvmAttributeGaugeSet());
        registry.register("jvm.classloader", new ClassLoadingGaugeSet());
        registry.register("jvm.descriptors", new FileDescriptorRatioGauge());
        registry.register("jvm.gc", new GarbageCollectorMetricSet());
        registry.register("jvm.memory", new MemoryUsageGaugeSet());
        registry.register("jvm.threads", new ThreadStatesGaugeSet());
        registry.register("jvm.buffers", new BufferPoolMetricSet(ManagementFactory
                .getPlatformMBeanServer()));

        return registry;
    }

    @Bean
    public MetricsProvider getMetricsProviders() {
        return new MetricsProvider(getMetricsRegistry());
    }

    @Bean
    public GraphiteReporter getGraphiteReporter() {
        return GraphiteReporter.forRegistry(getMetricsRegistry())
                .prefixedWith("java-app")
                .convertRatesTo(TimeUnit.MILLISECONDS)
                .convertDurationsTo(TimeUnit.MILLISECONDS)
                .filter(MetricFilter.ALL)
                .build(new Graphite(new InetSocketAddress(graphiteHost, graphitePort)));
    }

}
