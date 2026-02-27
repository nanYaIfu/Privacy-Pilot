import Foundation

enum ContentData {
    static let checkupQuestions: [CheckupQuestion] = [
        .init(id: 1, prompt: "Who can see your profile?", options: [
            .init(title: "Everyone (public)", score: 0, tip: "Set your profile to private so strangers can’t browse your posts."),
            .init(title: "Mostly public with some limits", score: 5, tip: "Limit what non-followers can see (bio, stories, activity)."),
            .init(title: "Private / friends-only", score: 10, tip: "Nice—review your follower list regularly.")
        ]),
        .init(id: 2, prompt: "Who can message you?", options: [
            .init(title: "Anyone", score: 0, tip: "Restrict message requests to reduce spam and unwanted DMs."),
            .init(title: "Friends + requests", score: 5, tip: "Turn off requests from strangers if you don’t use them."),
            .init(title: "People you follow / friends only", score: 10, tip: "Good—keep it tight to avoid random contact.")
        ]),
        .init(id: 3, prompt: "Do you share location in posts/stories?", options: [
            .init(title: "Often / live location", score: 0, tip: "Avoid real-time location—post later or keep it vague."),
            .init(title: "Sometimes / special occasions", score: 5, tip: "Use general locations (city) instead of exact places."),
            .init(title: "Rarely / never", score: 10, tip: "Great—location is one of the easiest ways to be tracked.")
        ]),
        .init(id: 4, prompt: "Do you review app permissions?", options: [
            .init(title: "Never", score: 0, tip: "Review permissions monthly—apps collect more than you think."),
            .init(title: "Sometimes", score: 5, tip: "Do a quick sweep: location, photos, mic, contacts."),
            .init(title: "Regularly", score: 10, tip: "Perfect—keep only what you actually use.")
        ]),
        .init(id: 5, prompt: "Is your phone/email visible on any profile?", options: [
            .init(title: "Yes", score: 0, tip: "Hide contact info—use in-app messaging instead."),
            .init(title: "Only to friends", score: 5, tip: "Check what’s visible on your public profile view."),
            .init(title: "No", score: 10, tip: "Good—less contact info = less targeting.")
        ]),
        .init(id: 6, prompt: "Do you accept requests from people you don’t know?", options: [
            .init(title: "Usually", score: 0, tip: "Strangers can be fake—only accept people you can verify."),
            .init(title: "Sometimes (if mutuals)", score: 5, tip: "Mutuals aren’t proof—scan account age + posts."),
            .init(title: "Rarely / never", score: 10, tip: "Nice—this reduces stalking and impersonation risk.")
        ]),
        .init(id: 7, prompt: "Do you tag your school/team/location often?", options: [
            .init(title: "Often", score: 0, tip: "School tags make you searchable—use vague tags or none."),
            .init(title: "Sometimes", score: 5, tip: "Avoid tagging when posting in real time."),
            .init(title: "Rarely / never", score: 10, tip: "Great—less searchable personal context.")
        ]),
        .init(id: 8, prompt: "Do you use 2FA + unique passwords?", options: [
            .init(title: "No / same password reused", score: 0, tip: "Use unique passwords + 2FA to protect accounts."),
            .init(title: "Some accounts", score: 5, tip: "Prioritize email + social accounts first."),
            .init(title: "Yes, for important accounts", score: 10, tip: "Excellent—account security protects privacy.")
        ]),
        .init(id: 9, prompt: "Do you allow resharing/remixing by anyone?", options: [
            .init(title: "Yes", score: 0, tip: "Turn off resharing if you don’t want your content spreading."),
            .init(title: "Depends on platform", score: 5, tip: "Lock it down on personal accounts, open it on creator accounts."),
            .init(title: "No / limited", score: 10, tip: "Nice—reduces loss of control and reposting.")
        ]),
        .init(id: 10, prompt: "Do you post photos that reveal schedules/addresses?", options: [
            .init(title: "Sometimes (unintentionally)", score: 0, tip: "Watch backgrounds: mail, street signs, calendars, school IDs."),
            .init(title: "Rarely", score: 5, tip: "Do a quick background scan before posting."),
            .init(title: "Never / I check", score: 10, tip: "Perfect—small details add up fast.")
        ])
    ]
    
    static let missions: [Mission] = [
        .init(id: 1, title: "School in Bio", minutes: 2,
              scenario: "A new follower says: “I go to your school too.” Your bio shows your school name and grade.",
              choices: [
                .init(text: "Keep it—it's normal.", isBest: false, feedback: "It makes you searchable and easier to target."),
                .init(text: "Remove school/grade and keep it general.", isBest: true, feedback: "Best move—reduce searchable info."),
                .init(text: "Block them immediately.", isBest: false, feedback: "Sometimes needed, but first reduce what strangers can learn.")
              ],
              takeaway: "Avoid searchable identifiers (school, grade, schedules). Keep bios general."),
        .init(id: 2, title: "Location Sticker Pressure", minutes: 2,
              scenario: "Friends want you to add a real-time location sticker to your story at a hangout spot.",
              choices: [
                .init(text: "Add it—only friends can see.", isBest: false, feedback: "Friends-of-friends, screenshots, and leaks happen."),
                .init(text: "Post later or use a general location (city).", isBest: true, feedback: "Best—keep the vibe without real-time tracking."),
                .init(text: "Refuse and don’t post anything.", isBest: false, feedback: "Safe, but you can also share safely with delay/general tags.")
              ],
              takeaway: "Avoid real-time location. Delay posts or use vague locations."),
        .init(id: 3, title: "Tagged in a Public Post", minutes: 2,
              scenario: "A friend tags you in a public post that includes your full name in the caption.",
              choices: [
                .init(text: "Ignore it.", isBest: false, feedback: "Tags + names increase searchability."),
                .init(text: "Ask them to remove your tag / name or set it to friends-only.", isBest: true, feedback: "Best—polite and effective."),
                .init(text: "Comment “delete this now.”", isBest: false, feedback: "May escalate. Ask privately first.")
              ],
              takeaway: "Control tags and searchable identifiers. Ask for edits calmly."),
        .init(id: 4, title: "Public = More Views", minutes: 3,
              scenario: "You want more views, so you’re considering switching your account to public.",
              choices: [
                .init(text: "Go public and keep everything the same.", isBest: false, feedback: "Going public amplifies risk if your info is personal."),
                .init(text: "Use a separate public creator account with limited personal info.", isBest: true, feedback: "Best—separate identity + safer content."),
                .init(text: "Stay private forever.", isBest: false, feedback: "Safe, but you can balance reach and privacy with separation.")
              ],
              takeaway: "If you want reach, separate public content from personal identity."),
        .init(id: 5, title: "Stranger DM After Your Story", minutes: 2,
              scenario: "A stranger DMs: “Saw your story at that park. You go there a lot?”",
              choices: [
                .init(text: "Reply politely with details.", isBest: false, feedback: "Details confirm patterns and habits."),
                .init(text: "Don’t engage; restrict DMs and remove location habits from posts.", isBest: true, feedback: "Best—reduce signals and access."),
                .init(text: "Post their message publicly to shame them.", isBest: false, feedback: "Can escalate. Use platform safety tools instead.")
              ],
              takeaway: "Don’t confirm routines. Reduce signals (location) and limit contact."),
        .init(id: 6, title: "Screenshot Moment", minutes: 2,
              scenario: "Someone asks you to send a “private” photo and promises it won’t be shared.",
              choices: [
                .init(text: "Send it—they promised.", isBest: false, feedback: "Screenshots and forwarding are always possible."),
                .init(text: "Don’t send; keep private content off chats.", isBest: true, feedback: "Best—assume anything can be saved."),
                .init(text: "Send it with “no screenshot” warning.", isBest: false, feedback: "Warnings don’t prevent screenshots.")
              ],
              takeaway: "Assume anything sent can be saved or shared. Keep private content private.")
    ]
}
