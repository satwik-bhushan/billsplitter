// src/screens/UserScreen.js
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const UserScreen = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>User Screen</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    padding: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
  },
});

export default UserScreen;
