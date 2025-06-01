'use client';

import { Card } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@radix-ui/react-avatar";
import { useGlobalState } from "@/components/context/GlobalStateContext";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { motion } from "framer-motion";
import { logout } from "@/utils/api";

export default function ProfilePage() {
    const { user, setUser } = useGlobalState();
    const [isEditing, setIsEditing] = useState(false);
    const [newEmail, setNewEmail] = useState(user?.email || '');
    const [newPassword, setNewPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');

    const userInitials = user?.username
        ?.split(' ')
        .map((n) => n[0])
        .join('')
        .toUpperCase() || 'U';

    const onLogOut = async () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
        setTimeout(async () => {
            await logout().then(() => { setUser(null) })
        }, 400);
    }

    const handleUpdateProfile = async (e: React.FormEvent) => {
        e.preventDefault();
        // TODO: Implement profile update logic
        setIsEditing(false);
    };

    return (
        <div className="flex items-center justify-center min-h-screen bg-gradient-to-b from-gray-900 via-blue-900/20 to-black">
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.5 }}
                className="container max-w-2xl px-4 py-12 mx-auto"
            >
                <Card className="p-8 space-y-6 border shadow-2xl bg-gray-800/30 backdrop-blur-xl border-blue-500/20 shadow-blue-500/10">
                    <div className="flex flex-col items-center space-y-6">
                        <motion.div
                            className="relative group"
                            whileHover={{ scale: 1.05 }}
                            transition={{ duration: 0.2 }}
                        >
                            <div className="absolute inset-0 transition-opacity duration-300 rounded-full opacity-50 bg-gradient-to-r from-blue-500/40 via-blue-600/40 to-blue-500/40 blur-xl group-hover:opacity-70" />
                            <Avatar className="relative z-10 w-32 h-32">
                                <AvatarImage src={user?.image || ''} alt={user?.username || 'User'} />
                                <AvatarFallback className="px-3 py-2 text-3xl text-white rounded-full bg-gradient-to-r from-blue-500/40 via-blue-600/40 to-blue-500/40">
                                    {userInitials}
                                </AvatarFallback>
                            </Avatar>
                        </motion.div>

                        <motion.div
                            className="space-y-2 text-center"
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: 0.2 }}
                        >
                            <h1 className="text-3xl font-semibold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-blue-600">
                                {user?.username}
                            </h1>
                            <p className="text-gray-400">
                                {user?.email}
                            </p>
                        </motion.div>

                        {!isEditing ? (
                            <motion.div
                                className="flex gap-4"
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.3 }}
                            >
                                <Button
                                    onClick={() => setIsEditing(true)}
                                    className="text-white transition-all duration-300 border bg-gradient-to-r from-blue-500/40 via-blue-600/40 to-blue-500/40 border-blue-500/30 hover:shadow-lg hover:shadow-blue-500/20"
                                >
                                    Edit Profile
                                </Button>
                                <Button
                                    onClick={onLogOut}
                                    className="text-white transition-all duration-300 border border-gray-600 bg-gray-700/50 hover:bg-red-500/20 hover:border-red-500/30"
                                >
                                    Logout
                                </Button>
                            </motion.div>
                        ) : (
                            <motion.form
                                onSubmit={handleUpdateProfile}
                                className="w-full space-y-4"
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.3 }}
                            >
                                <div className="space-y-2">
                                    <label className="text-sm text-gray-400">Email</label>
                                    <Input
                                        type="email"
                                        value={newEmail}
                                        onChange={(e) => setNewEmail(e.target.value)}
                                        className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50 focus:border-blue-500/50 focus:ring-blue-500/20"
                                    />
                                </div>
                                <div className="space-y-2">
                                    <label className="text-sm text-gray-400">New Password</label>
                                    <Input
                                        type="password"
                                        value={newPassword}
                                        onChange={(e) => setNewPassword(e.target.value)}
                                        className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50 focus:border-blue-500/50 focus:ring-blue-500/20"
                                    />
                                </div>
                                <div className="space-y-2">
                                    <label className="text-sm text-gray-400">Confirm Password</label>
                                    <Input
                                        type="password"
                                        value={confirmPassword}
                                        onChange={(e) => setConfirmPassword(e.target.value)}
                                        className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50 focus:border-blue-500/50 focus:ring-blue-500/20"
                                    />
                                </div>
                                <div className="flex gap-4 pt-4">
                                    <Button
                                        type="submit"
                                        className="text-white transition-all duration-300 border bg-gradient-to-r from-blue-500/40 via-blue-600/40 to-blue-500/40 border-blue-500/30 hover:shadow-lg hover:shadow-blue-500/20"
                                    >
                                        Save Changes
                                    </Button>
                                    <Button
                                        type="button"
                                        onClick={() => setIsEditing(false)}
                                        className="text-white transition-all duration-300 border border-gray-600 bg-gray-700/50 hover:bg-gray-600/50"
                                    >
                                        Cancel
                                    </Button>
                                </div>
                            </motion.form>
                        )}
                    </div>
                </Card>
            </motion.div>
        </div>
    );
}