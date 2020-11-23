import * as React from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import BePaid from 'react-native-bepaid';

export default function App() {
  React.useEffect(() => {
    BePaid.setAmount(228.123);
    BePaid.processPayment().then((res) => console.log(res));
  }, []);

  return (
    <View style={styles.container}>
      <Text>Hey</Text>
			<Button title={'Console'} onPress={() => console.log('Bruh')} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
});
