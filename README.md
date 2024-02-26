# koii_node_notifier
Notifies you whenever your koii node stops running.

# How to Setup the notifier:

Clone the github directory:

```
git clone https://github.com/eviangel/koii_node_notifier.git
```
Go the notifier directory:

```
cd koii_node_notifier
```
Make the scripts excutable:

```
chmod +x /root/koii_node_notifier/notifier_initialize.sh
chmod +x /root/koii_node_notifier/notifier.sh
```

Run the notifier_intializer script to initialize the configuration for the first time:

```
./notifier_initialize.sh
```

Now you will be asked for your discord webhook_url 

# how to get discord webhook_url:
First you have to create your own server (or use a server you own).

Then you need to create a new channel for notifier (this channel will be used to notify you if the node stops):

![create channel](https://github.com/eviangel/koii_node_notifier/assets/19639529/94ad1c48-04cb-4135-9a2f-fd75f3ec73e8)

Give the channel a name (in our example i will call it koii_notifier):

![name the channel](https://github.com/eviangel/koii_node_notifier/assets/19639529/e61d2876-9b25-4365-a6f0-467ec5800134)

Then go to the channel's settings:

![settings](https://github.com/eviangel/koii_node_notifier/assets/19639529/d84fa2c7-254e-4e0d-a91d-b1068fd8b01b)

Now go to Integrations then press on Create webhook:

![settings2](https://github.com/eviangel/koii_node_notifier/assets/19639529/df3e8272-6198-429f-8b85-4457fffcb9e0)

At last you need to copy the webhook_url by pressing on Copy Webhook URL:

![copy url](https://github.com/eviangel/koii_node_notifier/assets/19639529/2ab9999a-6953-4cb5-a1c3-e8e0bb386bc4)


Now we go back to the VPS and paste the webhook_URL.

Then you will asked for the frequency of the notifier 
for example if you write 1 then the notifier will check every one hour if the Koii node is running or not and will send you a message only if it was not running.

# How to deactivate the notifier:
Write the following command:

```
crontab -e
```

If you were asked which text editor you should use write 1.

Now delete the line that has koii_node_notifier/notifier.sh in it.
