"""Draws the made-up profile picture static/mia.jpg (a sunset over hills), so no real photo is used."""
import sys
from PIL import Image, ImageDraw, ImageFilter
import random, math
W=512; random.seed(7)
img=Image.new('RGB',(W,W))
px=img.load()
top=(48,58,120); mid=(232,120,110); low=(250,196,130)
for y in range(W):
    t=y/(W*0.62)
    if t<0.6: a,b,u=top,mid,t/0.6
    else: a,b,u=mid,low,min(1,(t-0.6)/0.4)
    c=tuple(int(a[i]+(b[i]-a[i])*u) for i in range(3))
    for x in range(W): px[x,y]=c
d=ImageDraw.Draw(img)
# sun
sun=Image.new('L',(W,W),0); ImageDraw.Draw(sun).ellipse((300,230,380,310),fill=255)
img.paste((255,226,170),(0,0),sun.filter(ImageFilter.GaussianBlur(2)))
def ridge(base,amp,seed,col,peaks):
    random.seed(seed); pts=[(0,W)]
    for x in range(0,W+8,8):
        h=base-sum(a*math.exp(-((x-p)/w)**2) for p,a,w in peaks)+random.uniform(-amp,amp)
        pts.append((x,h))
    pts.append((W,W)); d.polygon(pts,fill=col)
ridge(330,3,1,(120,82,120),[(90,120,70),(250,150,60),(420,100,80)])
ridge(360,4,2,(78,56,96),[(40,70,60),(180,110,55),(360,80,70),(500,60,50)])
ridge(395,3,3,(44,36,68),[(120,40,90),(330,55,80)])
# lake
for y in range(400,W):
    for x in range(W):
        r,g,b=px[x,800-y] if 800-y>0 else (40,40,60)
        f=0.55
        px[x,y]=(int(r*f+20*(1-f)),int(g*f+30*(1-f)),int(b*f+60*(1-f)))
img=img.filter(ImageFilter.GaussianBlur(0.8))
img.save(sys.path[0] + '/static/mia.jpg', quality=90)
