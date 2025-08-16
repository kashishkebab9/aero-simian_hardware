
docker run -it --rm \
  --gpus all \
  --network host --ipc host \
  --cap-add NET_ADMIN \
  --device /dev/ttyTHS1 \
  --device /dev/ttyTHS2 \
  --device /dev/gpiochip0 \
  --device /dev/gpiochip1 \
  -e DISPLAY=$DISPLAY \
  --runtime nvidia \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  aero-simian:jazzy-jetson bash
