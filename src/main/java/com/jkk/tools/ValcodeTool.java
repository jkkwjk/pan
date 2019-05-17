package com.jkk.tools;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * 生成验证码
 */
public class ValcodeTool {
	private static int width = 115;
	private static int height = 35;
	private static int codeNum = 4;
	private static int fontHeight = 30;
	private static char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
	private static int xx = 20;
	private static int codeY = 25;

	/**
	 * 获得随机验证码
	 * @return 返回map "code" -> 验证码文本; "img" -> 验证码图片
	 */
	public static Map<String,Object> getValcode () {
		BufferedImage img = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		Graphics gd = img.getGraphics();

		gd.setColor(Color.WHITE);
		gd.fillRect(0,0,width,height);

		Font font = new Font("Fixedsys",Font.BOLD,fontHeight);
		gd.setFont(font);

		StringBuffer resCode = new StringBuffer();
		Random random = new Random();
		for (int i=0; i<codeNum; ++i){
			String code = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);

			gd.setColor(getColor(random));

			Graphics2D g2d = (Graphics2D) gd.create();
			g2d.translate((i+1) * xx,codeY);
			int isFu = random.nextBoolean()?-1:1;
			g2d.rotate(isFu*random.nextInt(50) * Math.PI / 180);
			g2d.drawString(code,0,0);

			resCode.append(code);
		}
		//添加噪点
		for (int i = 0;i<100; ++i){
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			gd.setColor(getColor(random));
			gd.drawOval(x,y,1,1);
		}
		//添加干扰线
		for (int i = 0;i<10; ++i){
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			gd.setColor(getColor(random));
			gd.drawLine(x,y,random.nextInt(20),y+random.nextInt(10));
		}
		Map<String,Object> map = new HashMap<>();

		map.put("code",resCode);
		map.put("img",img);
		return map;
	}

	/**
	 * 随机产生颜色
	 * @param random
	 * @return
	 */
	public static Color getColor(Random random){
		return new Color(random.nextInt(255),random.nextInt(255),random.nextInt(255));
	}

	public static void main(String[] args) throws Exception{
		OutputStream out = new FileOutputStream(System.currentTimeMillis()+".jpg");
		Map<String,Object> map = ValcodeTool.getValcode();
		ImageIO.write((RenderedImage) map.get("img"), "jpeg", out);
		System.out.println("验证码的值为："+map.get("code"));
//		Random random = new Random();
//		System.out.print(random.nextDouble());
	}
}
