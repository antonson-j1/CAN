#include <SPI.h>
#include <mcp_can.h>
#include<Wire.h>
#include<Adafruit_MLX90614.h>
Adafruit_MLX90614 mlx = Adafruit_MLX90614(0x5A);
Adafruit_MLX90614 mlx2 = Adafruit_MLX90614(0x5B);
Adafruit_MLX90614 mlx3 = Adafruit_MLX90614(0x5C);
Adafruit_MLX90614 mlx4 = Adafruit_MLX90614(0x5D);
const int spiCSPin = 10;
int ledHIGH    = 1;
int ledLOW     = 0;
float a,b;
 

MCP_CAN CAN(spiCSPin);

void setup()
{
    Serial.begin(115200);

    while (CAN_OK != CAN.begin(CAN_250KBPS))
    {
        Serial.println("CAN BUS init Failed");
        delay(100);
    }
    Serial.println("CAN BUS Shield Init OK!");
    mlx.begin();
}


    
void loop()
{   

    float a = mlx.readObjectTempC() ;
   
    float c = mlx2.readObjectTempC() ;
  
    float e = mlx3.readObjectTempC() ;
  
    float g = mlx4.readObjectTempC() ;
 
  unsigned int b=(unsigned int) (a*100);
  unsigned int d=(unsigned int) (c*100);
  unsigned int f=(unsigned int) (e*100);
  unsigned int h=(unsigned int) (g*100);
  byte *p=(byte*) &b;
  byte *q=(byte*) &d;
  byte *r=(byte*) &f;
  byte *s=(byte*) &h;
  Serial.println("In loop");
  CAN.sendMsgBuf(0x43, 0, 2, p);
 delay(100);
    CAN.sendMsgBuf(0x44, 0, 2, q);
    delay(100);
      CAN.sendMsgBuf(0x45, 0, 8, r);
      delay(100);
  CAN.sendMsgBuf(0x46, 0, 8, s);
Serial.println(b);
Serial.println(d);
  delay(100);
  
}
