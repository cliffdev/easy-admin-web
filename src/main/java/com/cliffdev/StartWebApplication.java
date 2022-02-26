package com.cliffdev;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

@Slf4j
@MapperScan("com.cliffdev.modules.*.mapper")
@EnableScheduling
@SpringBootApplication
public class StartWebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext context= SpringApplication.run(StartWebApplication.class, args);
        context.registerShutdownHook();
        log.info("admin web 启动成功");
    }

}
