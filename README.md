# Autonomous Generative Spirit Summary

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
- What: Audio reactive wacter ripples, the more vibrant the environment, the more extreme the water vibrates, hence creating the ripples effect.
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
## Paperspace workflow
1. Create new machine ML-in-a-box template (Ubuntu 16.04 / 17.04), P4000, public IP address
2. Go into terminal of your Paperspace computer (password is sent to your email)
3. To change password `sudo passwd paperspace`
4. To launch `jupyter lab --no-browser` 
5. In your local terminal `ssh -NL 8157:localhost:8888 paperspace@PAPERSPACE_COMPUTER_IP_ADDRESS`

_If it doesn't connect, try changing 8888 to 8889 or switching to another wifi network_

6. Then go to your browser `https://localhost:8157`, and copy and paste the token given to you in the Paperspace terminal 

## How to background a process
So the training process can run without having Jupyter or Terminal open. Paperspace computer still has to be on.
1. Create a text file containing that command you want to run, rename that file to `run.sh`
2. Go to the folder containing that file then run the following `nohup sh run.sh > log.txt &`
3. The process will begin running, and it will continuously log its output to the file `log.txt`. You can come back to that folder and check on it later.
4. To force kill a process, go to Home, check `nvidia-smi`, find the process ID then `kill PROCESS_ID`

## DCGan
#### Prepare dataset
Find ways to scrape lots of images, ideally anything from 1k to 10k+
- [List of large datasets of images shared by Gene](https://docs.google.com/spreadsheets/d/1VijZSkQbqOvsvYBXdCx9UGu5zHGZPPpzwH2uHS-2XxQ/edit#gid=0)
- [Kaggle](https://www.kaggle.com/) (tons of free large datasets)
- [Tool to scrape Bing Images](https://github.com/montoyamoraga/edu13-scraping-bing-images). Hats off to Aaron!
- [Tool to scrape Google Images](https://github.com/montoyamoraga/edu13-scraping-bing-images). Works well for 500~1k. 
- [Tool to scrape Wikiart, can scrape by art genres or styles](https://github.com/ml4a/ml4a-guides/tree/experimental/utils)

Example command for using Wikiart (scrape then resize to 128x128)
```
python scrape_wikiart.py --style op-art --output_dir ../data
python dataset_utils.py --input_dir ../data/op-art --output_dir ../data/op-art_128 --frac 0.75 --w 128 --h 128 --augment --num_augment 1
```

Note: For some reasons all images have to be in the folder `images` inside `op-art_128`. Do so using this command `mv *.jpg images/`

#### Download the repository
```
git clone https://github.com/carpedm20/DCGAN-tensorflow
```
#### Train
```
python main.py --dataset images --data_dir FOLDER_CONTAIN_IMAGES_FOLDER --input_height 128 --output_height 128 --epoch 1000 --train
```
Warning: If your dataset is small (e.g. 2000 images), it will try to overfit, resulting in the output images looking similar to each other. I trained 1700 Ukiyo-e from Wikiart with 2000 epoch, things looked best at 500th epoch and just got worse from there!
#### Test
```
python main.py --dataset images --data_dir FOLDER_CONTAIN_IMAGES_FOLDER --input_height 128 --output_height 128
```
Note: If connection is lost, the training can still be resumed as "checkout" is saved frequently during the training process. Just execute the same command again.

## Char-rnn
#### Prepare dataset
Gather as much input data as you can for training. The more the better. Prepare `input.txt` file containing all your training data. Minimum 1MB to 25MB+

#### Setup ml5 environment
Follow the instruction [here](https://ml5js.org/docs/training-setup). 

Once everything is set up, go to directory `etc../miniconda3/bin` then execute `source activate ml5` to activate the environment. You should see (ml5) prepended before your terminal prompt.

#### Download the repository
```
git clone https://github.com/ml5js/training-lstm.git
cd training-lstm
```
Note: I've trained both on my computer following the [Ml5 LSTM](https://ml5js.org/docs/training-lstm) training instrucstion and on Paperspace computer using [Sherjil Ozair's version of char-rnn code](https://github.com/sherjilozair/char-rnn-tensorflow).

#### Train 
Create a new folder in the root of this project and inside that folder you should have one file called `input.txt`. 

A quick tip to concatenate many small disparate `.txt` files into one large training file `ls *.txt | xargs -L 1 cat >> input.txt`

Start training using the following command
```
python train.py --data_dir=./FOLDER_CONTAINS__INPUTTXT
```

This are the hyperparameters you can change to fit your data. [More info here](https://ml5js.org/docs/training-lstm)
```
python train.py --data_dir=./bronte \
--rnn_size 128 \
--num_layers 2 \
--seq_length 50 \
--batch_size 50 \
--num_epochs 50 \
--save_checkpoints ./checkpoints \
--save_model ./models
```

#### Run
Once the model is ready, point to it in your ml5 sketch:
```
const lstm = new ml5.LSTMGenerator('./models/your_new_model');
```

## Densecap
#### Installation
Follow the instruction [here](https://github.com/jcjohnson/densecap) to install Torch and dependencies
```
luarocks install torch
luarocks install nn
luarocks install image
luarocks install lua-cjson
luarocks install https://raw.githubusercontent.com/genekogan/stnbhwd/master/stnbhwd-scm-1.rockspec
luarocks install https://raw.githubusercontent.com/jcjohnson/torch-rnn/master/torch-rnn-scm-1.rockspec
luarocks install cutorch
luarocks install cunn
luarocks install cudnn (!DON'T USE THIS, INSTALL CUDNN FROM THE GENE'S FIX.SH BELOW)
luarocks install cudnn
```

Note: Install cudnn from [here](https://gist.github.com/genekogan/5569833564ab21460b2af25357771796)

### Download pretrained model 
```
sh scripts/download_pretrained_model.sh
```
Troubleshooting: Open `download_pretrained_model.sh` and place ... after wget

### Run new images
Put images in a folder inside `imgs` folder

```
th run_model.lua -input_dir imgs/FOLDER_NAME
```
This command will write results into the folder `vis/data`. Download `vis` folder and start a local HTTP server `python -m http.server` to see the results.

## What I made
- DCGan: Ukiyo-e
- DCGan: Concretism
- Pix2pix: Rachel Uwa
- Pix2pix: Kevin Hart
- Char-rnn: Southpark script
- Char-rnn: Beauy product reviews
- Image t-SNE: People with my name
- Audio t-SNE: Environmetal sounds
- Densecap: Police officers posing with cannabis plants
- Pose2pose: 70s fashion shopping
- Pose2pose: The Sims character walking
- Pose2pose: Björk
---

## List of tools
### 1. Deep learning tools
- **Neural-style** image-to-image (transfer style)
- [**Fast-style-transfer**](https://github.com/genekogan/fast-style-transfer) image-to-image
- **Pix2pix** image-to-image (anything)
- **Char-rnn** generate text in style (from prime)
- [**Detectron**](https://github.com/facebookresearch/Detectron) image-to-segments
- [**AttnGAN**](https://github.com/taoxugit/AttnGAN/) text-to-image
- **Im2txt** image-to-text
- **Densecap** image-to-text (captions)
- **Yolo** image-to-text (objects)
- **PoseNet/Densepose** image-to-person
- **DeepSpeech** speech-to-text
- **Doc2vec** paragraph-to-vector 
- **Wavenet / SampleRNN** make sounds (need to train your own)

### 2. Interactive ML tools
- Ml5 real-time image classifier
- Ml5 real-time image slider (regression)
- Ml5 PoseNet
- Sensors(Kinect/Leap/Arduino/etc)/Processing/Max/oF/etc <- Wekinator -> Processing/Max/oF/etc

### 3. DataViz ML tools
- Image t-SNE + reverse image search
- Audio t-SNE
- Text t-SNE

### 4. Others
- [Openface](https://github.com/cmusatyalab/openface) (Face recognition: Detect/cut/crop/cluster or classify)
- [Keras-GAN](https://github.com/eriklindernoren/Keras-GAN) (Keres implementation of GANs)
- [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) (Python library for scraping)
- [Prosthetic Knowledge](http://prostheticknowledge.tumblr.com/)
- [OpenFace](https://cmusatyalab.github.io/openface/)
- [TextCleaner](https://pypi.org/project/text_cleaner/)
- [RemoveNonAsciiChars](https://github.com/Gabriel-p/RemoveNonAsciiChars)

