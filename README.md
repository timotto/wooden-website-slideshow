# Wooden Webside Slideshow

Install some packages first:

```bash
apt-get install -y xserver-xorg-video-vesa chromium xinit screen psmisc
```

Copy the files from the ```dist/``` folder to the root of the machine. Make sure ```rc.local``` and ```go.sh``` are executable.

Put the websites you want to display into ```/home/pi/urls```.

The script kills the browser and uses a crude shift mechanism to walk through the ```urls``` file.
