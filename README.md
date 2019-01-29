# Automatic-Panorama-Stitching
Given a set of images belonging to different scenes, we construct all possible panoramas from the set, which is completely automated process

How to run the code:

Run the main function by giving the name of the directory consisting of the images (in '.jpg' format). The Function returns a cell of panoramic images and also displays the panoramas. 

Example: Assuming the dataset folder (image folder provided in the link) is in the same directory as the main.m file
panorama = main("./dataset/subset1");

Subset10 in the link is an example of multiple scene image set.

Dependencies:

Required Matlab Toolboxes

1. Image Processing Toolbox 

2. Computer Vision Toolbox 

3. Image Acquisition Toolbox

4. Optimization Toolbox 

Problem Definition:

Problem: Given multiple images of from different scenes, in a jumbled unordered way, reconstruct all possible panoramic images. The input images can be unordered, orientation, scale or illumination invariant. It also takes care of the noise images which are not a part of the scene during the reconstruction process.

Action Plan:

1. The first step in the algorithm is to find the common features in all the images using SIFT Descriptor, which is independent of rotation and scale.

2. Next we group images with maximum matching features and use some fixed number of images for reconstruction. A probabilistic
model is used to verify all the matches.

3.Find the connected components of the image set, that is group all the images belonging to a single scene.

4. Then we find the pairwise homographies between the matched images beloning to each component using RANSAC.

5. Next we use Bundle Adjustment by adding each matched image one by one to the original image using the above extracted pairwise homographies. It will remove the accumulated errors and disregard multiple constraints between images.

6. Finally we stitch the images using the pairwise homographies using multi-band blending for the overlapping regions. 


Timeline: 

20th -31st October : Feature extraction, Image Matching and finding conected components 

1st - 20th November : RANSAC and Bundle Adjustment 

20th - 28th November: Image stitching with Blending 

[Presentation Link](https://docs.google.com/presentation/d/1jv7As1NQ3JOqF7OHfIIapFaIIX_-CAiRQUqouRHQnPA/edit?fbclid=IwAR0TnFPqjF_0Pa_WPTD7gnwGDxtzySBUZGqUgzvpD_VPc1jO3m7qc8sm23c#slide=id.p)

[Input images link](https://drive.google.com/drive/folders/1XP3BaWB0U0lJjffVC_X3GeDMNg_XLaCW?fbclid=IwAR2mqQghSFJlJ3Hf92M-eIjvdp_uUf3DJyVb0zZZeDucMJ4ie1-vsQxtDx4)

[Output Images link](https://drive.google.com/drive/folders/1z0xpNJEx1fm9SXNqMr9aY2IdyQMfH1rj?fbclid=IwAR2pAGjJmGvZhf8eQk4o_tdp7qYqReahpV3GwNiYF3FuBqSMFOQsLUFMawM)
