import time


def transmissionrate(dev, direction, timestep):
    """Return the transmisson rate of a interface under linux
    dev: devicename
    direction: rx (received) or tx (sended)
    timestep: time to measure in seconds
    """
    path = f"/sys/class/net/{dev}/statistics/{direction}_bytes"
    with open(path, "r") as f1:
        bytes_before = int(f1.read())
    time.sleep(timestep)
    with open(path, "r") as f2:
        bytes_after = int(f2.read())
    return (bytes_after - bytes_before) / timestep


byterate = transmissionrate("eth0", "tx", 10) / 10
print(f"tx byterate: {byterate}")
while byterate > 16 * 1024:  # 16KB/s
    byterate = transmissionrate("eth0", "tx", 10) / 10
    print(f"tx byterate: {byterate}")
print("tx traffic is low, Task is Done, Exit")
