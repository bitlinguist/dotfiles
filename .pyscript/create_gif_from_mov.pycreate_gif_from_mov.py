import os
import sys

def closeProcess():
    print('Failed')
    exit(1)

def convertMovToPng(filepath):
    try:
        os.system("~/ffmpeg/ffmpeg -i " + filepath + " -r 10 ./.temp/png/out%04d.png ")
    except:
        return closeProcess()

def convertPngsToGifs():
    try:
        os.system("sips -s format gif " + cwd + "/.temp/png/*.png --out " + cwd + "/.temp/gifs")
    except:
        return closeProcess()

def combineGif(filename, path):
    gifskiBase = "gifsicle --optimize=3 --resize=1072x444 --delay=10 --loopcount ";
    try:
        os.system(gifskiBase + cwd + "/.temp/gifs/*.gif > " + path + filename + ".gif")
    except:
        return closeProcess()

def cleanup(cwd):
    os.system("rm -fr " + cwd + "/.temp")

filepath = sys.argv[1]
pathList = str(filepath).split('/')
pathList.reverse()
filename = pathList[0].split('.')[0]
path = filepath.split(filename)[0]
cwd = os.getcwd()

try:
    os.system("mkdir -p " + cwd + "/.temp/png")
    os.system("mkdir -p " + cwd + "/.temp/gifs")
except:
    closeProcess()
finally:
    convertMovToPng(filepath)
    convertPngsToGifs()
    combineGif(filename, path)
    cleanup(cwd)
