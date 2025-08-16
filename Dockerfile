# ROS 2 Jazzy (Ubuntu 24.04, arm64) + Python/pip, Jetson-friendly
FROM arm64v8/ros:jazzy-ros-base

SHELL ["/bin/bash", "-lc"]

# Env for NVIDIA Container Runtime (Jetson)
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics \
    ROS_DISTRO=jazzy \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Base tools, Python 3/pip, colcon/dev tools, and GLVND/EGL/OpenGL libs
RUN apt-get update && apt-get install -y --no-install-recommends \
      locales tzdata curl ca-certificates gnupg lsb-release \
      python3 python3-pip python3-venv \
      ros-dev-tools \
      build-essential git \
      # GLVND / EGL / OpenGL stubs that many CUDA/graphics stacks expect
      libglvnd0 libgl1 libglx0 libegl1 libgles2 \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*


# Minimal entrypoint that sources ROS 2
RUN printf '#!/usr/bin/env bash\nset -e\nsource /opt/ros/jazzy/setup.bash || true\nexec "$@"\n' > /ros_entrypoint.sh \
    && chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

