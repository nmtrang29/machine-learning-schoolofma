# Autonomous Generative Spirit Summary
My documentation for the [Autonomous Generative Spirit](http://schoolofma.org/autonomous-generative-spirit/), 4-week intensive course at School of Machines focusing on creative applications of Machine Learning. 

## Week 1: Supervised ML using real-time interactive tools 

### Types of supervised ML that we discussed
Classification, Regression and Dynamic Time Wrapping

### Tools
Wekinator (middle-man), Processing, Ofx, ml5js

### General Outline
- Introduction to Machine Learning + projects from Andreas and Gene
- Sending and receiving OSC messages via Wekinator using Processing and Openframeworks 
- Make something into Wekinator input/output
- Controlling Wekinator via OSC
- Wekinator with other softwares (Ableton, Touch Designer, Unity…)

### What I made 
##### 1. Study with me:
- Tools: Processing (video-100-inputs) > Wekinator > Processing
- What: Play video of someone studying and nag my sister everytime she gets distracted/looks away from her notebooks
- How: Train Processing video-100-inputs to classify between class 1 (person looking down in front of the camera) and class 2 (person looking away). Then the OSC messages containing the class to Wekinator. Output Processing sketch receives the class and play audio files everytime the class switches from 1 to 2.

##### 2. Neck stretcher:
- Tools: Processing (openCV) + Shader
- What: Use openCV library to detect the position of human face, then stretch the part below it (neck) using custom shader. Andreas helped with the Processing sketch, Meredith helped writing the shader. I barely did anything lol.

##### 3. Audio reactive water:
- Tools: Processing (sound-14-inputs) > Wekinator > Processing
- What: Audio reactive water ripples, the more vibrant the environment, the more extreme the water vibrates, hence creating the ripples effect.
- How: Train Processing sound-14-inputs to give regression value (0.0 silent, 1.0 loud), then via Wekinator send the value to the Processing water sketch.

##### 4. Mole reader:
- Tools: ml5js (facetracker-knn)
- What: Tell you the meaning behind your facial moles (in browser)
- How: Use Facetracker-knn to track and put text on certain points on your face to represent where the moles are. Train the model to recognise between class 1 and class 2. Class 1, meanings of moles are all neutral. Class 2, when a person smile, all the meanings become positive. 

#### Notes
- [Andreas documentation of Week 1](https://andreasref.github.io/som/)
- There are tons of programs that can send and receive OSC messages, meaning they can work with Wekinator
- [Kadenze course on "ML for Musicians and Artists" by Wekinator author Rebecca Fiebrink](https://www.kadenze.com/courses/machine-learning-for-musicians-and-artists-v)
- Aaron has a list of intersting links on Github, lots of cool art-tech projects
---

## Week 2+3: Generative models and generative art
### Paperspace workflow
1. Create new machine ML-in-a-box template (Ubuntu 16.04 / 17.04), P4000, public IP address
2. Go into terminal of your Paperspace computer (password is sent to your email)
3. To change password `sudo passwd paperspace`
4. To launch `jupyter lab --no-browser` 
5. In your local terminal `ssh -NL 8157:localhost:8888 paperspace@PAPERSPACE_COMPUTER_IP_ADDRESS`

_If it doesn't connect, try changing 8888 to 8889 or switching to another wifi network_

6. Then go to your browser `https://localhost:8157`, and copy and paste the token given to you in the Paperspace terminal 

### How to background a process
So the training process can run without having Jupyter or Terminal open. Paperspace computer still has to be on.
1. Create a text file containing that command you want to run, rename that file to `run.sh`
2. Go to the folder containing that file then run the following `nohup sh run.sh > log.txt &`
3. The process will begin running, and it will continuously log its output to the file `log.txt`. You can come back to that folder and check on it later.
4. To force kill a process, go to Home, check `nvidia-smi` then `kill XXXX`

### DCGan
#### Prepare dataset
Find ways to scrape lots of images, ideally anything from 1k to 10k+
- [List of large datasets of images shared by Gene](https://docs.google.com/spreadsheets/d/1VijZSkQbqOvsvYBXdCx9UGu5zHGZPPpzwH2uHS-2XxQ/edit#gid=0)
- [Tool to scrape Bing Images](https://github.com/montoyamoraga/edu13-scraping-bing-images). Hats off to Aaron!
- [Tool to scrape Google Images](https://github.com/montoyamoraga/edu13-scraping-bing-images). Works well for 500~1k. 
- [Tool to scrape Wikiart, can scrape by art genres or styles](https://github.com/ml4a/ml4a-guides/tree/experimental/utils)

Example command for using Wikiart (scrape then resize to 128x128)
```
python scrape_wikiart.py --style op-art --output_dir ../data
python dataset_utils.py --input_dir ../data/op-art --output_dir ../data/op-art_128 --frac 0.75 --w 128 --h 128 --augment --num_augment 1
```

Note: For some reasons all images have to be in the folder `images` inside `op-art_128`. Do so using this command `mv *.jpg images/`

#### Train model 
```
git clone https://github.com/carpedm20/DCGAN-tensorflow
python main.py --dataset images --data_dir ../_art-DCGAN/datasets/concretism_new_128/ --input_height 128 --output_height 128 --epoch 1000 --train
```
#### Test model 
```
python main.py --dataset images --data_dir ../_art-DCGAN/datasets/concretism_new_128/ --input_height 128 --output_height 128
```

Note: If connection is lost, the training can still be resumed as "checkout" is saved frequently during the training process. Just execute the same command again.







Pix2pix
Neural style transfer
Char-rnn + text bots
GANs
