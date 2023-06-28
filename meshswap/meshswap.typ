#set text(size: 16pt, font: "IBM Plex Serif")
#set par(justify: true)

#align(center, text(25pt)[
  A Better Block Detection Algorithm For MCprep's Meshswap
])
#align(center)[
  By StandingPad
]

= Problem
We want to meshswap certain blocks with a fancier version of them. However, we've been given a full OBJ of faces and we need to identify each block with a given material. While we could select all faces and split them by loose parts, that leads to a mess. Instead, we want to be able to find blocks without having to go through that whole process

While MCprep currently does this, the algorithm is slow, unreadable, and not really fit for geometry nodes (which are the future of meshswap). This algorithm aims to be faster, easier to read, and easier for one to wrap their head around. In addition, this algorithm was designed with geometry nodes in mind, and in could be used for a geometry nodes based mesh swap.

Ideally we would want to spend the least amount of time calculating what are the bounds of full blocks. The algorithm described here can get all of a block's faces with only a single face known and return a point that acts as the block's origin.

Thankfully Minecraft OBJs have some things we can assume, which helps us a lot in this case.

= Some Basic Principles
A face is a plane whose area is defined as follows:
$ F_A = l * w $

Where $l$ is the length and $w$ is the width. In addition, all cubic Minecraft blocks have a 3rd variable $h$ for height, are made up of 6 faces, and whose volume is defined as follows:
$ B_V = l * w * h $

Given a block $B$ with the dimensions $1m * 2m * 3m$ (where $m$ is meters) and a face $F$ with the dimensions $1m * 3m$, the following is true:
$ F_A = 1 * 3       $
$ B_V = F_A * 2     $
$ B_V = (1 * 3) * 2 $
$ d = 2             $

Where $d$ is the depth.

Every face has a normal as well, which defines the orientation. For our use cases, the normal is a line perpenidcular to the face in question. In addtion, $-n$ (where $n$ is a normal) should be interpreted as the opposite orientation of the face.

In addition, every face also has a material $M$, which is the material they have.

Let's move on to the algorithm.
= Algorithm in Detail
Now that we've covered some basics, we can now move on to the algorithm.
== Cubic Blocks
Given the dimensions $l$, $w$, and $h$, a target material $M$, a face $F_alpha$ with material $M$, and the normal of $F_alpha$ (called $n_alpha$), we can do the following:
1. Take the dimensions of $F_alpha$ and compare them to the given dimensions $l$, $w$, and $h$. The dimension not represented in those 3 shall be $d$.
2. Find a face $F_beta$ that is $d$ away, opposite of $n_alpha$. If $F_beta$ exists, then its normal shall be $n_beta$ and the material it has shall be $M_beta$. If $F_beta$ does not exist, move on to Step 4.
3. Provided $F_beta$ exists, it is part of the same block as $F_alpha$ if the following are true:
$ n_beta = -n_alpha $
$ M_beta = M        $
4. For every edge $E$ from $F_alpha$, find a face $F_gamma$ that shares $E$ with $F_alpha$ If $F_gamma$ exists, then its normal shall be $n_gamma$ and the material it has shall be $M_gamma$. If $F_gamma$ does not exist, move on to Step 6.
5. Provided $F_gamma$ exists, it is part of the same block as $F_alpha$ and $F_beta$ if the following is true:
$ n_gamma perp n_alpha $
$ n_gamma perp n_beta  $
$ M_gamma = M          $
6. With all faces found, the origin of the block lies on the point where all normals (when extended from the face inward) intersect. If only 2 faces exist, then let the distance between the centers of both faces be $D$, where the midpoint of $D$ is the origin. If one face exists, then put the origin $1/2 d$ away from $-n_alpha$. The rotation of the block can be found by getting the face that defines the orientation of the block.

== Non-Cubic Blocks
Some blocks are not cubic in shape and instead are made with 2 intersecting planes. We can easily modify the algorithm to handle this:
1. Given a target material $M$ and a face $F_alpha$, find a face $F_beta$ that intersects $F_alpha$. If $F_beta$ exists, then let $M_beta$ be the material of $F_beta$. If $F_beta$ does not exist, then the algorithm terminates.
2. Provided $F_beta$ exists, it is part of the same block as $F_alpha$ if the following is true:
$ M_beta = M $
3. Let $I$ be the line formed by the intersection of $F_alpha$ and $F_beta$, as per the _Plane Intersection Postulate_, and let $G$ be a stright line parallel to the top of the OBJ. If the following is true, then the blocked formed by $F_alpha$ and $F_beta$ is stright:
$ I perp G $

Otherwise, the blocked formed by $F_alpha$ and $F_beta$ is not stright.

4. With both faces and $I$, let the origin be at the vertex formed by the intersection of the bottom edges of $F_alpha$ and $F_beta$, and let the rotation of the vertex be the rotation of $I$.
