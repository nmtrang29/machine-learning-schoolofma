// Copyright (c) 2018 ml5
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

/* ===
ml5 Example
PoseNet example using p5.js
=== */

let poseNet;
let poses = [];
let circleSize = 20;

let myMovie;

function setup() {
  frameRate(10);
  createCanvas(1024, 512);
    
  myMovie = createVideo("bjork2.mp4");

  // Create a new poseNet method with a single detection
  // poseNet = ml5.poseNet(myMovie, modelReady);
  poseNet = ml5.poseNet(myMovie, 'single', modelReady);
  // This sets up an event that fills the global variable "poses"
  // with an array every time new poses are detected
  poseNet.on('pose', function(results) {
    poses = results;
  });
   
    myMovie.hide();
    myMovie.loop();
}

function modelReady() {
  select('#status').html('Model Loaded');
}

function draw() {
  rect(0, 0, 512, 512);
  drawKeypoints();
  // drawSkeleton();
  //saveFrames();
  //save("render/myCanvas" + frameCount + ".jpg");

  image(myMovie, 512, 0);
  fill(0);
  noStroke();
}

// A function to draw ellipses over the detected keypoints
function drawKeypoints()  {
  // Loop through all the poses detected
  for (let i = 0; i < poses.length; i++) {
    // For each pose detected, loop through all the keypoints
    let pose = poses[i].pose;
    for (let j = 0; j < pose.keypoints.length; j++) {
      // A keypoint is an object describing a body part (like rightArm or leftShoulder)
      let keypoint = pose.keypoints[j];
      // Only draw an ellipse is the pose probability is bigger than 0.2
      if (keypoint.score > 0.3) {
        fill(255, 0, 0);
        noStroke();
        ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
      }

      //nose

      if (j == 0) {
        if (keypoint.score > 0.3) {
          fill(255, 100, 0);
          ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
        }
      }

      //right leg

      if (j == 11 || j == 13 || j == 15) {
        if (keypoint.score > 0.3) {
          fill(0, 255, 0);
          ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
        }
      }

      //left leg

      if (j == 12 || j == 14 || j == 16) {
        if (keypoint.score > 0.3) {
          fill(0, 255, 0);
          ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
        }
      }

      //left arm

      if (j == 6 || j == 8 || j == 10) {
        if (keypoint.score > 0.3) {
          fill(0, 0, 255);
          ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
        }
      }

      //right arm

      if (j == 5 || j == 7 || j == 9) {
        if (keypoint.score > 0.3) {
          fill(0, 0, 255);
          ellipse(keypoint.position.x, keypoint.position.y, circleSize, circleSize);
        }
      }

      if (j == 5 || j == 6 || j == 7 || j == 8) {
        if (keypoint.score > 0.3) {
          stroke(0, 0, 255);
          strokeWeight(4);
          line(pose.keypoints[j].position.x, pose.keypoints[j].position.y, pose.keypoints[j+2].position.x, pose.keypoints[j+2].position.y);
        }

      }

      if (j == 11 || j == 12 || j == 13 || j == 14) {
        if (keypoint.score > 0.3) {
          stroke(0, 255, 0);
          strokeWeight(4);
          line(pose.keypoints[j].position.x, pose.keypoints[j].position.y, pose.keypoints[j+2].position.x, pose.keypoints[j+2].position.y);
        }

      }
    }
  }
}

// // A function to draw the skeletons
// function drawSkeleton() {
//   // Loop through all the skeletons detected
//   for (let i = 0; i < poses.length; i++) {
//     let skeleton = poses[i].skeleton;
//     // For every skeleton, loop through all body connections
//     for (let j = 0; j < skeleton.length; j++) {
//       let partA = skeleton[j][0];
//       let partB = skeleton[j][1];
//       stroke(255, 0, 0);
//       strokeWeight(4);
//       text(j, partA.position.x, partA.position.y);
//       line(partA.position.x, partA.position.y, partB.position.x, partB.position.y);

//       // for (j == 5) {
//       //   stroke(255, 255, 0);
//       // }
//     }
//   }
// }
