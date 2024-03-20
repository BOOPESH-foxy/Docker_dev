# Use the official ROS Noetic image as the base image
FROM ros:noetic
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory inside the container
WORKDIR /workspace/src

# Copy the ROS package from the host machine to the container
COPY   /src/agribot_simulation  /workspace/src

# Update package dependencies
RUN apt-get update && apt-get install -y \
    ros-noetic-ros-base \
    ros-noetic-gazebo-ros \
    && rm -rf /var/lib/apt/lists/*

# Initialize catkin workspace

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash \
    && cd /workspace \
    && catkin_make \
    && source devel/setup.bash "

# Set up ROS environment variables
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_IP=127.0.0.1
ENV ROS_HOSTNAME=127.0.0.1

# Run simulation launch file
#CMD ["roslaunch", "agribot_simulation", "agribot.launch"]
CMD ["gazebo"]

