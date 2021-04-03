import * as functions from "firebase-functions";

import * as admin from "firebase-admin";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

admin.initializeApp();

exports.user = functions.firestore
    .document("chat/{msgId}")
    .onCreate((snap, context) => {
      admin.messaging().sendToTopic("chat", {
        notification: {
          title: snap.data().userName,
          body: snap.data().text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",

        },
      });
    });
