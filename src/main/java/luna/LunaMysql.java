package luna;

import luna.common.Bootstrap;
/**
 * 
* Copyright: Copyright (c) 2017 XueErSi
*
* @version v1.0.0
* @author GaoXing Chen
*
* Modification History:
* Date         Author          Version			Description
*---------------------------------------------------------*
* 2017年11月29日     GaoXing Chen      v1.0.0		  添加注释
 */
public class LunaMysql {
    public static void main( String[] args ){
        String config = "conf/example.yml";
        if(args.length==1){
            config = args[0];
        }
        Bootstrap bootstrap = new Bootstrap(config);
        bootstrap.start();
        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() {
                bootstrap.stop();
            }
        });
    }
}
