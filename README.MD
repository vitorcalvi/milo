![alt text for screen readers](https://repository-images.githubusercontent.com/488006361/cbd94f28-bcfa-4fa4-a784-a9a57678b3fa)

Some drafts 
### Docker - To use ASLA Audio
```
docker run -it -v /run/user/1000/pulse/native:/run/user/1000/pulse/native \
-e PULSE_SERVER=unix:/run/user/1000/pulse/native  \
--privileged vcalvi/dof-wavego-picotts:v1.1 bash
```
