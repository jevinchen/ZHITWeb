<%@ page language="java" contentType="image/jpeg" import="java.util.*,java.awt.*,java.awt.image.*,javax.imageio.*" pageEncoding="utf-8"%>
<%!
Color getRandColor(int fc,int bc){
	Random random=new Random();
	if(fc>255) fc=255;
	if(bc>255) bc=255;
	int r=fc+random.nextInt(bc-fc);
	int g=fc+random.nextInt(bc-fc);
	int b=fc+random.nextInt(bc-fc);
	return new Color(r,g,b);
	}
 %>
 <%
 //设置页面不缓存
  response.setHeader("Pragma","no-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires",0);
  //在内存中创建对象
  int width=80,height=30;
  BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
  //获取图形上下文
  Graphics g=image.getGraphics();
  //生成随机类
  Random random =new Random();
  //设定背景色
  g.setColor(getRandColor(200,250));
  g.fillRect(0,0,width,height);
  //设定字体
  g.setFont(new Font("Times New Roman",Font.PLAIN,18));
  //画边框
  //g.setColor(new Color());
  //g.drawRect(0,0,width-1,height-1);
  //随机产生155条干扰线，是图像中的认证码不易被其他程序探测到
  g.setColor(getRandColor(160,200));
  for(int i=0;i<155;i++)
  {
  	int x=random.nextInt(width);
  	int y=random.nextInt(height);
  	int x1=random.nextInt(12);
  	int y1=random.nextInt(12);
  	g.drawLine(x,y,x+x1,y+y1);
  }
  //取随机产生的认证码（4位数）
  String sRand="";
  for(int i=0;i<4;i++){
  	String rand=String.valueOf(random.nextInt(10));
  	sRand+=rand;
  	//将认证码显示在图像中
  	g.setColor(new Color(20+random.nextInt(110),40+random.nextInt(110),20+random.nextInt(110)));
  	g.drawString(rand,13*i+6,16);
  }
  //将认证码存入session中
  session.setAttribute("rand", sRand);
  //图像生效
  g.dispose();
  //输出图像到页面
  ImageIO.write(image,"JPEG",response.getOutputStream());
   out.clear();
   out = pageContext.pushBody();
  %>